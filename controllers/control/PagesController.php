<?php
namespace controllers\control;

use components\Pagination;
use components\User;
use core\BaseController;

class PagesController extends BaseController{
    

    public function actionIndex(){
    $user = new User();
    if(!$user->isAuth()){
        header("Location: /control/index");
    }
    $getUserPrfile = $user->getProfile();
    if($getUserPrfile['role'] != 'admin')  parent::ShowError(404, "Страница не найдена!");
    
    $getSettings = $this->db->query('SELECT * FROM ga_settings');
    $settings = $getSettings->fetch();
    
    $title = "Страницы";
    
    if(parent::isAjax()){
        
        
    }else{
    
    
    $countComments = $this->db->query('SELECT * FROM ga_pages');
    $count = $countComments->rowCount();
    

    $pagination = new Pagination();
    $per_page = 15;
    $result = $pagination->create(array('per_page' => $per_page, 'count' => $count));

    $getComments = $this->db->query('SELECT * FROM ga_pages ORDER BY id DESC LIMIT '.$result['start'].', '.$per_page.'');
    $getComments = $getComments->fetchAll();

    $content = $this->view->renderPartial("control/pages/index", ['comments' => $getComments, 'ViewPagination' => $result['ViewPagination']]);
 
    $this->view->render("control/main", ['content' => $content, 'title' => $title]);   
    }
    
    }
    
    public function actionAdd(){
    $getSettings = $this->db->query('SELECT * FROM ga_settings');
    $settings = $getSettings->fetch();    
        
    $user = new User();
    if(!$user->isAuth()){
        header("Location: /control/index");
    }
    
    $getUserPrfile = $user->getProfile();
    if($getUserPrfile['role'] != 'admin')  parent::ShowError(404, "Страница не найдена!");
    
    $title = "Добавление страницы";
     
    
    if(parent::isAjax()){
        
    $titlePage = $_POST['title'];
    $text = $_POST['text'];
    

    $this->db->exec("INSERT INTO ga_pages (title, text, date_create) 
    VALUES('$titlePage', '$text', '".time()."')");
    
    
    $answer['status'] = "success";
    $answer['success'] = "Страница успешно добавлена";
    exit(json_encode($answer)); 
        
    }else{
        

    $content = $this->view->renderPartial("control/pages/add", []);
 
    $this->view->render("control/main", ['content' => $content, 'title' => $title]);   
    
    }
    }
    
    
    public function actionEdit(){
    $getSettings = $this->db->query('SELECT * FROM ga_settings');
    $settings = $getSettings->fetch();    
        
    $user = new User();
    if(!$user->isAuth()){
        header("Location: /control/index");
    }
    
    $getUserPrfile = $user->getProfile();
    if($getUserPrfile['role'] != 'admin')  parent::ShowError(404, "Страница не найдена!");

    if(isset($_GET['id'])) $id = (int)$_GET['id']; else $id = '';
    
    $title = "Изменение страницы #$id";
     
    $getInfoPage = $this->db->prepare('SELECT * FROM ga_pages WHERE id = :id');
    $getInfoPage->execute(array(':id' => $id));
    $getInfoPage = $getInfoPage->fetch();
    if(empty($getInfoPage)) parent::ShowError(404, "Страница не найдена!");
    
    
    if(parent::isAjax()){
        
    $titlePage = $_POST['title'];
    $text = $_POST['text'];
    


    $sql = "UPDATE ga_pages SET title = :title, text =:text WHERE id= :id";
    $update = $this->db->prepare($sql);                                        
    $update->bindParam(':title', $titlePage);   
    $update->bindParam(':text', $text); 
    $update->bindParam(':id', $id); 
    $update->execute();     
    
    $answer['status'] = "success";
    $answer['success'] = "Страница успешно изменена";
    exit(json_encode($answer)); 
        
    }else{
        

    $content = $this->view->renderPartial("control/pages/edit", ['data' => $getInfoPage]);
 
    $this->view->render("control/main", ['content' => $content, 'title' => $title]);   
    
    }
    }
    

    
    public function actionRemove(){
    $user = new User();
    if(!$user->isAuth()){
        header("Location: /control/index");
    }
    $getUserPrfile = $user->getProfile();
    if($getUserPrfile['role'] != 'admin')  parent::ShowError(404, "Страница не найдена!");
    
    if(parent::isAjax()){
    if(isset($_GET['id'])) $id = (int)$_GET['id']; else $id = '';
    $sql = "DELETE FROM ga_pages WHERE id =  :id";
    $stmt = $this->db->prepare($sql);
    $stmt->bindParam(':id', $id, PDO::PARAM_INT);   
    $stmt->execute();     

    }
    
        
    }
    
    
    
    
}