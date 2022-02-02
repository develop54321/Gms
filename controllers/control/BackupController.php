<?php
namespace controllers\control;

use components\User;
use core\BaseController;
use PDO;

set_time_limit(0);
class BackupController extends BaseController{

    public $backup_folder = 'backups';

    public function actionIndex(){



    $user = new User();
    if(!$user->isAuth()){
        $this->actionLogin();
    }
    $getUserPrfile = $user->getProfile();
    if($getUserPrfile['role'] != 'admin')  parent::ShowError(404, "Страница не найдена!");

    $getSettings = $this->db->query('SELECT * FROM ga_settings');
    $settings = $getSettings->fetch();

    $title = "Резервные копии";

    if(parent::isAjax()){


    }else{

    $getBackups = $this->db->query('SELECT * FROM ga_backup');
    $getBackups = $getBackups->fetchAll();

    $content = $this->view->renderPartial("control/backup/index", ['backups' => $getBackups]);

    $this->view->render("control/main", ['content' => $content, 'title' => $title]);
    }

    }


    public function actionDownload(){
    $user = new User();
    if(!$user->isAuth()){
        $this->actionLogin();
    }
    $getUserPrfile = $user->getProfile();
    if($getUserPrfile['role'] != 'admin')  parent::ShowError(404, "Страница не найдена!");

    $getSettings = $this->db->query('SELECT * FROM ga_settings');
    $settings = $getSettings->fetch();

    $type = $_GET['type'];
    $currentDate = date("d-m-Y");
    if($type == 'base'){

    $hash = "db_".md5(mt_rand(111,999));
    $name = $currentDate."-".$hash.".sql";
    $full_path = $this->backupDB($this->backup_folder ,"$currentDate-$hash");
    $this->db->exec("INSERT INTO ga_backup (name, type, date_create, hash) 
    VALUES('$name', 'database', ".time().", '$full_path')");
    header("Location: /control/backup");

    }else parent::ShowError(404, "Страница не найдена!");


    }

    private function backupDB($backup_folder, $backup_name){
    $fullFileName = $backup_folder . '/' . $backup_name . '.sql';
    $command = 'mysqldump -h' . DB_HOST . ' -u' . DB_USER . ' -p' . DB_PASSWORD . ' ' . DB_NAME . ' > ' . $fullFileName;
    shell_exec($command);
    return $fullFileName;
    }

    public function actionRemove(){
    $control = new Control();
    if(!$control->isAuth()) header("Location: /control/index");
    if(parent::isAjax()){
    if(isset($_GET['id'])) $id = (int)$_GET['id']; else $id = '';

    $getInfoBackup = $this->db->prepare('SELECT * FROM ga_backup WHERE id = :id');
    $getInfoBackup->execute(array(':id' => $id));
    $getInfoBackup = $getInfoBackup->fetch();

    @unlink($getInfoBackup['hash']);

    $sql = "DELETE FROM ga_backup WHERE id =  :id";
    $stmt = $this->db->prepare($sql);
    $stmt->bindParam(':id', $id, PDO::PARAM_INT);
    $stmt->execute();
    }


    }







}
