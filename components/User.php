<?php

namespace components;

use core\BaseController;
use PDO;

class User extends BaseController
{
    public function isAuth()
    {
        if (isset($_COOKIE['id_user']) && isset($_COOKIE['hash'])) {
            $id_user = $_COOKIE['id_user'];
            $hash = $_COOKIE['hash'];
            $check = $this->db->prepare('SELECT * FROM ga_users WHERE id = :id and hash = :hash');
            $check->bindValue(":id", $id_user);
            $check->bindValue(":hash", $hash);
            $check->execute();
            if ($check->rowCount() == '0') return false;
            else return $check->fetch();
        } else {
            return false;
        }
    }

    public function getProfile()
    {
        $id_user = (int)$_COOKIE['id_user'];
        $check = $this->db->prepare('SELECT * FROM ga_users WHERE id = :id ');
        $check->bindValue(":id", $id_user);
        $check->execute();
        return $check->fetch();
    }

    public function getProfileBy($param, $data)
    {
        $check = $this->db->prepare('SELECT * FROM ga_users WHERE ' . $param . ' = :' . $param . ' ');
        $check->bindValue(":$param", $data);
        $check->execute();
        return $check->fetch();
    }

    public function refill($data)
    {
        $getInfoPay = $this->db->prepare('SELECT * FROM ga_pay_logs WHERE id = :id');
        $getInfoPay->execute(array(':id' => $data['inv_id']));
        $getInfoPay = $getInfoPay->fetch();

        if (empty($getInfoPay)) {
            throw new \Exception("payment account not found");
        }
        $getInfoPay = json_decode($getInfoPay['content'], true);

        if ($getInfoPay['amount'] != $data['amount'])
        {
            throw new \Exception("wrong data");
        }

        $getInfoUser = $this->db->prepare('SELECT * FROM ga_users WHERE id = :id');
        $getInfoUser->execute(array(':id' => $getInfoPay['id_user']));
        $getInfoUser = $getInfoUser->fetch();

        $newBalance = $getInfoUser['balance'] + $getInfoPay['amount'];
        $sql = "UPDATE ga_users SET balance = :balance  WHERE id = :id";
        $update = $this->db->prepare($sql);
        $update->bindParam(':balance', $newBalance, PDO::PARAM_INT);
        $update->bindParam(':id', $getInfoPay['id_user'], PDO::PARAM_INT);
        $update->execute();

        $status = "paid";
        $sql = "UPDATE ga_pay_logs SET status = :status WHERE id = :id";
        $update = $this->db->prepare($sql);
        $update->bindParam(':status', $status);
        $update->bindParam(':id', $data['inv_id']);
        $update->execute();

        return true;
    }
}