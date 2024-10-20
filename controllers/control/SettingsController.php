<?php

namespace controllers\control;


use components\User;
use core\BaseController;

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


}