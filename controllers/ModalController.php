<?php

namespace controllers;

use core\BaseController;
use Exception;
use xPaw\SourceQuery\SourceQuery;

class ModalController extends BaseController
{


    public function actionIndex()
    {

        if (parent::isAjax()) {
            $action = $_POST['action'];
            switch ($action) {
                case "answer":
                    $param = $_POST['param'];
                    $type = $_POST['type'];

                    return $this->view->render("modals/answerModal", ['param' => $param, 'type' => $type]);
                    break;

                case "serverServices":
                    $id = (int)$_POST['param'];
                    $getInfoServer = $this->db->prepare('SELECT * FROM ga_servers WHERE id = :id');
                    $getInfoServer->execute(array(':id' => $id));
                    $getInfoServer = $getInfoServer->fetch();

                    return $this->view->render("modals/serverServicesModal", ['data' => $getInfoServer]);
                    break;

                case "vote":
                    $id = (int)$_POST['param'];
                    $type = $_POST['type'];
                    $getInfoServer = $this->db->prepare('SELECT * FROM ga_servers WHERE id = :id');
                    $getInfoServer->execute(array(':id' => $id));
                    $getInfoServer = $getInfoServer->fetch();


                    return $this->view->render("modals/voteModal", ['type' => $type, 'data' => $getInfoServer]);
                    break;

                case "showPlayers":
                    $id = (int)$_POST['param'];

                    $getInfoServer = $this->db->prepare('SELECT * FROM ga_servers WHERE id = :id');
                    $getInfoServer->execute(array(':id' => $id));
                    $getInfoServer = $getInfoServer->fetch();


                    $Query = new SourceQuery();
                    $Players = [];
                    if (in_array($getInfoServer['game'], ['cs', 'csgo', 'css', 'tf2', 'ld2', 'rust', 'csgo2'])) {


                        $port = $getInfoServer['port'];
                        if ($getInfoServer['query_port'] !== null){
                            $port = (int)$getInfoServer['query_port'];
                        }

                 
                        try {
                            $Query->Connect($getInfoServer['ip'], $port, 3, SourceQuery::GOLDSOURCE);


                            $Players = $Query->GetPlayers();

                        } catch (Exception $e) {
                            print_r($e);
                            $Exception = $e;
                        }finally {
                            $Query->Disconnect();
                        }
                    } else if ($getInfoServer['game'] == 'samp') {
                        $GameQ = new \GameQ\GameQ();
                        $GameQ->addServer([
                            'type' => 'samp',
                            'host' => $getInfoServer['ip'] . ":" . $getInfoServer['port'],
                        ]);
                        $results = $GameQ->process();
                        $Info = array_shift($results);
                        $Players = $Info['players'];

                    } else if ($getInfoServer['game'] == 'mta') {
                        $GameQ = new \GameQ\GameQ();
                        $GameQ->addServer([
                            'type' => 'mta',
                            'host' => $getInfoServer['ip'] . ":" . $getInfoServer['port'],
                        ]);
                        $results = $GameQ->process();
                        $Info = array_shift($results);
                        $Players = $Info['players'];

                    }



                    echo $this->view->render("modals/showPlayersModal", [
                        'data' => $getInfoServer,
                        'players' => $Players,
                        'game' => $getInfoServer['game']
                    ]);
                    break;


                default:

                    break;
            }
        }


    }


}
