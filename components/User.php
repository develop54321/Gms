<?php

namespace components;

use core\BaseController;
use PDO;

class User extends BaseController
{

    public function isAuth()
    {
        if (isset($_SESSION['id_user']) && isset($_SESSION['hash'])) {
            $id_user = $_SESSION['id_user'];
            $hash = $_SESSION['hash'];
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
        $id_user = (int)$_SESSION['id_user'];
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
        $getSettings = $this->db->query('SELECT * FROM ga_settings');
        $settings = $getSettings->fetch();

        $getInfoPay = $this->db->prepare('SELECT * FROM ga_pay_logs WHERE id = :id');
        $getInfoPay->execute(array(':id' => $data['inv_id']));
        $getInfoPay = $getInfoPay->fetch();

        if (empty($getInfoPay)) parent::ShowError(404, "�������� �� �������!");
        $getInfoPay = json_decode($getInfoPay['content'], true);

        if ($getInfoPay['amout'] != $data['amout']) parent::ShowError(404, "�������� �� �������!");

        $getInfoUser = $this->db->prepare('SELECT * FROM ga_users WHERE id = :id');
        $getInfoUser->execute(array(':id' => $getInfoPay['id_user']));
        $getInfoUser = $getInfoUser->fetch();

        $newBalance = $getInfoUser['balance'] + $getInfoPay['amout'];
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