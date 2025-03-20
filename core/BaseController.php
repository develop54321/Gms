<?php

namespace core;

use RuntimeException;

abstract class BaseController
{
    protected View $view;
    protected Database $db;

    public function __construct()
    {
        $this->view = new View(TMPL_DIR);
        $this->db = new Database();
    }

    public function ShowError($code, $data)
    {

        switch ($code) {
            case "404":
                header("HTTP/1.0 404 Not Found");
                break;

            case "403":
                header('HTTP/1.0 403 Forbidden');

                break;

                case "400":
                header('HTTP/1.0 400 Bad Request');

                break;
        }


        $content = $this->view->renderPartial("404", ['code' => $code, 'data' => $data]);

        $this->view->render("main", ['content' => $content, 'title' => $data]);
        exit();

    }

    public function isAjax(): bool
    {
        if (!empty($_SERVER['HTTP_X_REQUESTED_WITH']) && strtolower($_SERVER['HTTP_X_REQUESTED_WITH']) == 'xmlhttprequest') {
            return true;
        }

        return false;
    }

    public function readPostJson()
    {
        $postData = file_get_contents('php://input');


        if ($postData === false) {
            throw new RuntimeException('Не удалось прочитать данные из тела запроса.');
        }

        $decodedData = json_decode($postData, true);

        if (json_last_error() !== JSON_ERROR_NONE) {
            throw new RuntimeException('Ошибка при декодировании JSON: ' . json_last_error_msg());
        }

        return $decodedData;
    }
}