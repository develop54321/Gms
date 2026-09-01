<?php

namespace controllers\control;

use PDO;

class PromocodesController extends AbstractController
{

    public function index()
    {
        $title = "Промокоды";

        $getPromoCodes = $this->db->query('SELECT * FROM ga_promo_codes ORDER BY id DESC');
        $getPromoCodes = $getPromoCodes->fetchAll();

        $content = $this->view->renderPartial("promocodes/index", ['promoCodes' => $getPromoCodes]);
        $this->view->render("main", ['content' => $content, 'title' => $title]);
    }

    public function add()
    {
        $title = "Добавление промокода";

        if (parent::isAjax()) {
            $code = trim(strip_tags($_POST['code'] ?? ''));
            $amount = (int)($_POST['amount'] ?? 0);

            $maxActivations = trim($_POST['maxActivations'] ?? '');
            $maxActivations = $maxActivations === '' ? null : (int)$maxActivations;

            $period = trim($_POST['period'] ?? '');
            $expiresAt = $period === '' ? null : time() + ((int)$period * 86400);

            $comment = strip_tags($_POST['comment'] ?? '');

            if ($code === '') {
                exit(json_encode(['status' => 'error', 'error' => 'Введите код промокода']));
            }

            if ($amount <= 0) {
                exit(json_encode(['status' => 'error', 'error' => 'Сумма должна быть больше нуля']));
            }

            $check = $this->db->prepare('SELECT 1 FROM ga_promo_codes WHERE UPPER(code) = UPPER(:code)');
            $check->execute([':code' => $code]);
            if ($check->rowCount() > 0) {
                exit(json_encode(['status' => 'error', 'error' => 'Такой промокод уже существует']));
            }

            $stmt = $this->db->prepare(
                'INSERT INTO ga_promo_codes (code, amount, max_activations, status, expires_at, comment, date_add)
                 VALUES (:code, :amount, :max_activations, 1, :expires_at, :comment, :date_add)'
            );
            $stmt->execute([
                ':code' => $code,
                ':amount' => $amount,
                ':max_activations' => $maxActivations,
                ':expires_at' => $expiresAt,
                ':comment' => $comment,
                ':date_add' => time(),
            ]);

            exit(json_encode(['status' => 'success', 'success' => 'Промокод успешно добавлен']));
        }

        $content = $this->view->renderPartial("promocodes/add", []);
        $this->view->render("main", ['content' => $content, 'title' => $title]);
    }

    public function edit()
    {
        if (isset($_GET['id'])) $id = (int)$_GET['id']; else $id = 0;

        $title = "Изменение промокода";

        $getInfoPromo = $this->db->prepare('SELECT * FROM ga_promo_codes WHERE id = :id');
        $getInfoPromo->execute([':id' => $id]);
        $getInfoPromo = $getInfoPromo->fetch();
        if (empty($getInfoPromo)) parent::ShowError(404, "Промокод не найден!");

        if (parent::isAjax()) {
            $amount = (int)($_POST['amount'] ?? 0);

            $maxActivations = trim($_POST['maxActivations'] ?? '');
            $maxActivations = $maxActivations === '' ? null : (int)$maxActivations;

            $status = (int)($_POST['status'] ?? 1);
            $comment = strip_tags($_POST['comment'] ?? '');

            if ($amount <= 0) {
                exit(json_encode(['status' => 'error', 'error' => 'Сумма должна быть больше нуля']));
            }

            $stmt = $this->db->prepare(
                'UPDATE ga_promo_codes
                 SET amount = :amount, max_activations = :max_activations, status = :status, comment = :comment
                 WHERE id = :id'
            );
            $stmt->execute([
                ':amount' => $amount,
                ':max_activations' => $maxActivations,
                ':status' => $status,
                ':comment' => $comment,
                ':id' => $id,
            ]);

            exit(json_encode(['status' => 'success', 'success' => 'Промокод успешно изменён']));
        }

        $content = $this->view->renderPartial("promocodes/edit", ['data' => $getInfoPromo]);
        $this->view->render("main", ['content' => $content, 'title' => $title]);
    }

    public function remove()
    {
        if (parent::isAjax()) {
            if (isset($_GET['id'])) $id = (int)$_GET['id']; else $id = 0;
            $stmt = $this->db->prepare('DELETE FROM ga_promo_codes WHERE id = :id');
            $stmt->bindParam(':id', $id, PDO::PARAM_INT);
            $stmt->execute();
        }
    }
}
