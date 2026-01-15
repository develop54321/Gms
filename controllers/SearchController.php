<?php

namespace controllers;

use core\BaseController;

class SearchController extends BaseController
{
    public function index()
    {
        $title = "Поиск сервера";
        $query = null;
        $getServers = [];

        if ($this->isPostRequest() && !empty($_POST['query'])) {
            $query = trim($_POST['query']);

            if (preg_match('/^([\d\.]+)(?::(\d+))?$/', $query, $m)) {
                $ip   = $m[1];
                $port = $m[2] ?? null;

                $sql = 'SELECT * FROM ga_servers WHERE ip = :ip';
                $params = [':ip' => $ip];

                if ($port !== null) {
                    $sql .= ' AND port = :port';
                    $params[':port'] = (int)$port;
                }

                $stmt = $this->db->prepare($sql);
                $stmt->execute($params);
                $getServers = $stmt->fetchAll();
            } else {
                $stmt = $this->db->prepare(
                    'SELECT *,
                     MATCH(hostname, map) AGAINST (:q IN BOOLEAN MODE) AS relevance
                     FROM ga_servers
                     WHERE MATCH(hostname, map) AGAINST (:q IN BOOLEAN MODE)
                     ORDER BY relevance DESC
                     LIMIT 50'
                );

                // + обязательно для BOOLEAN MODE
                $stmt->execute([':q' => $query . '*']);
                $getServers = $stmt->fetchAll();
            }
        }

        $content = $this->view->renderPartial(
            "search",
            [
                'servers' => $getServers,
                'query'   => $query
            ]
        );

        $this->view->render("main", [
            'content' => $content,
            'title'   => $title
        ]);
    }
}
