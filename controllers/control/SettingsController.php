<?php

namespace controllers\control;

use components\Mail;
use Exception;
use PHPMailer\PHPMailer\PHPMailer;

class SettingsController extends AbstractController
{
    public function index()
    {
        $getSettings = $this->db->query('SELECT * FROM ga_settings');
        $settings = $getSettings->fetch();

        $title = "Настройки";

        if (parent::isAjax()) {
            $content = [];
            $global_settings = $_POST['global_settings'];
            $content['global_settings']['site_name'] = $global_settings['site_name'];
            $content['global_settings']['expired_time_payment'] = $global_settings['expired_time_payment'];
            $content['global_settings']['auto_add_server'] = $global_settings['auto_add_server'];
            $content['global_settings']['count_servers_main'] = $global_settings['count_servers_main'];
            $content['global_settings']['count_servers_top'] = $global_settings['count_servers_top'];
            $content['global_settings']['count_servers_vip'] = $global_settings['count_servers_vip'];
            $content['global_settings']['count_servers_boost'] = $global_settings['count_servers_boost'];
            $content['global_settings']['count_servers_color'] = $global_settings['count_servers_color'];
            $content['global_settings']['count_servers_gamemenu'] = $global_settings['count_servers_gamemenu'];
            # on/off services
            $content['global_settings']['top_on'] = $global_settings['top_on'];        // Top
            $content['global_settings']['boost_on'] = $global_settings['boost_on'];        // Boost
            $content['global_settings']['vip_on'] = $global_settings['vip_on'];        // Vip
            $content['global_settings']['color_on'] = $global_settings['color_on'];        // Color
            $content['global_settings']['gamemenu_on'] = $global_settings['gamemenu_on'];        // Gamemenu_on
            $content['global_settings']['votes_on'] = $global_settings['votes_on'];        // Votes_on

            $comments = $_POST['comments'];
            $content['comments']['guest_allow'] = $comments['guest_allow'];
            $content['comments']['moderation'] = $comments['moderation'];


            $contentJson = json_encode($content);

            $id = 1;
            $sql = "UPDATE ga_settings SET content = :content WHERE id= :id";
            $update = $this->db->prepare($sql);
            $update->bindParam(':content', $contentJson);
            $update->bindParam(':id', $id);
            $update->execute();


            $answer['status'] = "success";
            $answer['success'] = "Настройки успешно сохранены";
            exit(json_encode($answer));

        } else {
            $settings = json_decode($settings['content'], true);
            $content = $this->view->renderPartial("settings/index", ['settings' => $settings]);

            $this->view->render("main", ['content' => $content, 'title' => $title]);

        }
    }


    public function mail()
    {
        $getSettings = $this->db->query('SELECT params_mail FROM ga_settings');
        $settings = $getSettings->fetch();

        $title = "Настройки почты";

        if (parent::isAjax()) {
            $mailParams = $_POST['mail_params'];

            $paramsMail = [];
            $paramsMail['type'] = $mailParams['type'];
            $paramsMail['from'] = $mailParams['from'];
            $paramsMail['smtp_server'] = $mailParams['smtp_server'];
            $paramsMail['smtp_port'] = $mailParams['smtp_port'];
            $paramsMail['encrypt'] = $mailParams['encrypt'];
            $paramsMail['smtp_username'] = $mailParams['smtp_username'];
            $paramsMail['smtp_password'] = $mailParams['smtp_password'];
            $paramsMail['auto_tls'] = $mailParams['auto_tls'] ?? false;

            $paramsMailJson = json_encode($paramsMail);
            $id = 1;
            $sql = "UPDATE ga_settings SET params_mail = :params_mail WHERE id= :id";
            $update = $this->db->prepare($sql);
            $update->bindParam(':params_mail', $paramsMailJson);
            $update->bindParam(':id', $id);
            $update->execute();


            $answer['status'] = "success";
            $answer['success'] = "Настройки успешно сохранены";
            exit(json_encode($answer));
        }else {

            $settings = json_decode($settings['params_mail'], true);


            $content = $this->view->renderPartial("settings/mail", ['settings' => $settings]);
            $this->view->render("main", ['content' => $content, 'title' => $title]);

        }
    }


    public function mailTest()
    {
        $getSettings = $this->db->query('SELECT params_mail FROM ga_settings');
        $settings = $getSettings->fetch();
        $settings = json_decode($settings['params_mail'], true);

        $title = "Тестирование почты";

        if (parent::isAjax()) {
            $mailParams = $_POST['mail_params'];
            $mail = new Mail();

            try {
                $mail->send(
                    $settings,
                    [
                        'address' => $mailParams['address'],
                        'subject' => $mailParams['subject'],
                        'content' => $mailParams['message'],
                    ]
                );

                $answer['status'] = "success";
                $answer['success'] = "Тестовое письмо отправлено, проверьте почту";
                exit(json_encode($answer));
            }catch (Exception $e) {
                $answer['status'] = "error";
                $answer['error'] = $e->getMessage();
                exit(json_encode($answer));
            }

        }else {
            $content = $this->view->renderPartial("settings/mail_test");
            $this->view->render("main", ['content' => $content, 'title' => $title]);
        }
    }

}