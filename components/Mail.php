<?php

namespace components;

use core\BaseController;
use Exception;
use PHPMailer\PHPMailer\PHPMailer;
class Mail extends BaseController
{

    public function send($params, $message)
    {
        $mail = new PHPMailer(true);

        try {

            $html = $this->view->renderPartial("mail/default", [
                "message" => $message,
            ]);

            if ($params['type'] === 'smtp') {
                $mail->isSMTP();
                $mail->Host = $params['smtp_server'] ?? '';
                $mail->Port = $params['smtp_port'] ?? 587;
                $mail->SMTPAuth = !empty($params['smtp_username']) && !empty($params['smtp_password']);
                $mail->Username = $params['smtp_username'] ?? '';
                $mail->Password = $params['smtp_password'] ?? '';
                $mail->SMTPSecure = $params['encrypt'] === 'ssl' ? PHPMailer::ENCRYPTION_SMTPS : ($params['encrypt'] === 'tls' ? PHPMailer::ENCRYPTION_STARTTLS : '');
                $mail->SMTPAutoTLS = isset($params['auto_tls']) ? (bool)$params['auto_tls'] : true;
            }

            $mail->setFrom($params['from']);

            $mail->addAddress($message['address']);

            $mail->isHTML(true);
            $mail->Subject = $message['subject'];
            $mail->Body = $html;

            $mail->send();


        } catch (Exception $e) {
           throw new \Exception("Email sending failed: ' . $mail->ErrorInfo . '");
        }
    }


}