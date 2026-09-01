<?php

namespace components;

use core\BaseController;
use PDO;
use PDOException;

class PromoCode extends BaseController
{
    public function activate(string $code, int $userId): array
    {
        $code = trim($code);
        if ($code === '') {
            return ['success' => false, 'message' => 'Введите промокод'];
        }

        $stmt = $this->db->prepare('SELECT * FROM ga_promo_codes WHERE UPPER(code) = UPPER(:code)');
        $stmt->execute([':code' => $code]);
        $promo = $stmt->fetch();

        if (empty($promo)) {
            return ['success' => false, 'message' => 'Промокод не найден'];
        }

        if ((int)$promo['status'] !== 1) {
            return ['success' => false, 'message' => 'Промокод больше не активен'];
        }

        if ($promo['expires_at'] !== null && (int)$promo['expires_at'] < time()) {
            return ['success' => false, 'message' => 'Срок действия промокода истёк'];
        }

        if ($promo['max_activations'] !== null && (int)$promo['activations_count'] >= (int)$promo['max_activations']) {
            return ['success' => false, 'message' => 'Лимит активаций промокода исчерпан'];
        }

        $checkUsed = $this->db->prepare('SELECT 1 FROM ga_promo_code_activations WHERE id_promo = :id_promo AND id_user = :id_user');
        $checkUsed->execute([':id_promo' => $promo['id'], ':id_user' => $userId]);
        if ($checkUsed->rowCount() > 0) {
            return ['success' => false, 'message' => 'Вы уже активировали этот промокод'];
        }

        try {
            $this->db->beginTransaction();

            $guard = $this->db->prepare(
                'UPDATE ga_promo_codes
                 SET activations_count = activations_count + 1
                 WHERE id = :id
                   AND status = 1
                   AND (expires_at IS NULL OR expires_at > :now)
                   AND (max_activations IS NULL OR activations_count < max_activations)'
            );
            $guard->execute([':id' => $promo['id'], ':now' => time()]);

            if ($guard->rowCount() === 0) {
                $this->db->rollBack();
                return ['success' => false, 'message' => 'Промокод недоступен для активации'];
            }

            $insert = $this->db->prepare(
                'INSERT INTO ga_promo_code_activations (id_promo, id_user, amount, date_add)
                 VALUES (:id_promo, :id_user, :amount, :date_add)'
            );
            $insert->execute([
                ':id_promo' => $promo['id'],
                ':id_user' => $userId,
                ':amount' => $promo['amount'],
                ':date_add' => time(),
            ]);

            $updateBalance = $this->db->prepare('UPDATE ga_users SET balance = balance + :amount WHERE id = :id_user');
            $updateBalance->bindValue(':amount', $promo['amount']);
            $updateBalance->bindValue(':id_user', $userId, PDO::PARAM_INT);
            $updateBalance->execute();

            $this->db->commit();

            return ['success' => true, 'amount' => $promo['amount']];
        } catch (PDOException $e) {
            if ($this->db->inTransaction()) {
                $this->db->rollBack();
            }

            if ($e->getCode() === '23000') {
                return ['success' => false, 'message' => 'Вы уже активировали этот промокод'];
            }

            throw $e;
        }
    }
}
