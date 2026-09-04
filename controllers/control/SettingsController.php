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

            $errors = [];
            $content = [];
            $currentSettings = json_decode($settings['content'] ?? '', true) ?: [];

            $global = $_POST['global_settings'] ?? [];
            $comments = $_POST['comments'] ?? [];

            /** --------------------
             * ВАЛИДАЦИЯ
             * ------------------- */

            // Название сайта
            $site_name = trim($global['site_name'] ?? '');
            if (mb_strlen($site_name) < 3) {
                $errors[] = 'Название сайта должно содержать минимум 3 символа';
            }

            // Описание сайта (meta description)
            $site_description = trim($global['site_description'] ?? '');

            // Логотип / favicon — сохраняем текущие, если новый файл не загружен
            $logoPath = $currentSettings['global_settings']['logo_path'] ?? null;
            $faviconPath = $currentSettings['global_settings']['favicon_path'] ?? null;

            try {
                if (!empty($_FILES['logo']['name'])) {
                    $logoPath = $this->handleImageUpload($_FILES['logo'], 'logo', [
                        'image/png' => 'png', 'image/jpeg' => 'jpg', 'image/gif' => 'gif', 'image/webp' => 'webp',
                    ]);
                }
                if (!empty($_FILES['favicon']['name'])) {
                    $faviconPath = $this->handleImageUpload($_FILES['favicon'], 'favicon', [
                        'image/png' => 'png', 'image/x-icon' => 'ico', 'image/vnd.microsoft.icon' => 'ico',
                    ]);
                }
            } catch (\RuntimeException $e) {
                $errors[] = $e->getMessage();
            }

            if (!empty($global['remove_logo'])) $logoPath = null;
            if (!empty($global['remove_favicon'])) $faviconPath = null;

            // Срок оплаты
            $expired_time_payment = (int)($global['expired_time_payment'] ?? 0);
            if ($expired_time_payment < 1) {
                $errors[] = 'Срок истечения оплаты должен быть больше 0';
            }

            // Авто добавление сервера
            $auto_add_server = in_array($global['auto_add_server'] ?? null, ['0', '1'], true)
                ? (int)$global['auto_add_server']
                : 0;

            // Числовые лимиты серверов
            $numberFields = [
                'count_servers_main',
                'count_servers_top',
                'count_servers_vip',
                'count_servers_boost',
                'count_servers_color',
                'count_servers_gamemenu',
            ];

            foreach ($numberFields as $field) {
                $value = (int)($global[$field] ?? 0);
                if ($value < 0) {
                    $errors[] = "Поле {$field} не может быть отрицательным";
                }
                $content['global_settings'][$field] = $value;
            }

            // Если есть ошибки — сразу выходим
            if (!empty($errors)) {
                exit(json_encode([
                    'status' => 'error',
                    'error'  => implode('<br>', $errors)
                ]));
            }

            /** --------------------
             * СОХРАНЕНИЕ
             * ------------------- */

            $content['global_settings']['site_name'] = $site_name;
            $content['global_settings']['site_description'] = $site_description;
            $content['global_settings']['logo_path'] = $logoPath;
            $content['global_settings']['favicon_path'] = $faviconPath;
            $content['global_settings']['expired_time_payment'] = $expired_time_payment;
            $content['global_settings']['auto_add_server'] = $auto_add_server;

            // on/off сервисы
            $switches = [
                'top_on',
                'boost_on',
                'vip_on',
                'color_on',
                'gamemenu_on',
                'votes_on',
            ];

            foreach ($switches as $switch) {
                $content['global_settings'][$switch] =
                    isset($global[$switch]) && $global[$switch] == 1 ? 1 : 0;
            }

            // Комментарии
            $content['comments']['guest_allow'] =
                isset($comments['guest_allow']) && $comments['guest_allow'] == 1 ? 1 : 0;

            $content['comments']['moderation'] =
                isset($comments['moderation']) && $comments['moderation'] == 1 ? 1 : 0;

            // JSON
            $contentJson = json_encode($content, JSON_UNESCAPED_UNICODE);

            $sql = "UPDATE ga_settings SET content = :content WHERE id = 1";
            $update = $this->db->prepare($sql);
            $update->bindParam(':content', $contentJson);
            $update->execute();

            exit(json_encode([
                'status' => 'success',
                'success' => 'Настройки успешно сохранены'
            ]));

        } else {

            $settings = json_decode($settings['content'], true);
            $content = $this->view->renderPartial("settings/index", [
                'settings' => $settings
            ]);

            $this->view->render("main", [
                'content' => $content,
                'title' => $title
            ]);
        }
    }

    /**
     * Validates an uploaded image (real MIME sniff via getimagesize + size cap) and
     * moves it into public/img/branding/ under a fixed name — never the client's
     * original filename — so it can't be used for path traversal or to smuggle a
     * non-image file in. Returns the public URL to store in settings.
     */
    private function handleImageUpload(array $file, string $baseName, array $allowedMimes): string
    {
        if (!empty($file['error']) && $file['error'] !== UPLOAD_ERR_OK) {
            throw new \RuntimeException("Ошибка загрузки файла «{$baseName}»");
        }

        if ($file['size'] > 2 * 1024 * 1024) {
            throw new \RuntimeException("Файл «{$baseName}» больше 2 МБ");
        }

        $imageInfo = @getimagesize($file['tmp_name']);
        if ($imageInfo === false || !isset($allowedMimes[$imageInfo['mime']])) {
            throw new \RuntimeException("Файл «{$baseName}» должен быть изображением (" . implode(', ', array_unique($allowedMimes)) . ")");
        }

        $ext = $allowedMimes[$imageInfo['mime']];
        $dir = ROOT_DIR . 'public/img/branding';
        if (!is_dir($dir)) mkdir($dir, 0755, true);

        // drop any stale file left over from a previous upload with a different extension
        foreach (array_unique($allowedMimes) as $staleExt) {
            if ($staleExt !== $ext) @unlink($dir . '/' . $baseName . '.' . $staleExt);
        }

        $destination = $dir . '/' . $baseName . '.' . $ext;
        if (!move_uploaded_file($file['tmp_name'], $destination)) {
            throw new \RuntimeException("Не удалось сохранить файл «{$baseName}»");
        }

        return '/public/img/branding/' . $baseName . '.' . $ext;
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