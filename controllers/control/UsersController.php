<?php 

class UsersController extends BaseController{
    
    public function actionSearch(){
    $user = new User();
    if(!$user->isAuth()){
        header("Location: /control/index");
    }
    $getUserPrfile = $user->getProfile();
    if($getUserPrfile['role'] != 'admin')  parent::ShowError(404, "Страница не найдена!");
    
    $getSettings = $this->db->query('SELECT * FROM ga_settings');
    $settings = $getSettings->fetch();
    
    $title = "Поиск пользователя";
    
    if(isset($_POST['query'])){
    $query = $_POST['query'];

    
    $getUsers = $this->db->prepare('SELECT * FROM ga_users WHERE email = :email ');
    $getUsers->bindValue(":email", $query);
    $getUsers->execute();
    $getUsers = $getUsers->fetchAll();
    
    $content = $this->view->renderPartial("control/users/index", ['users' => $getUsers, 'action' => 'search']);
    }
    
    $this->view->render("control/main", ['content' => $content, 'title' => $title]);   
    }
    
    
    public function actionIndex(){
    $user = new User();
    if(!$user->isAuth()){
        header("Location: /control/index");
    }
    $getUserPrfile = $user->getProfile();
    if($getUserPrfile['role'] != 'admin')  parent::ShowError(404, "Страница не найдена!");
    
    $getSettings = $this->db->query('SELECT * FROM ga_settings');
    $settings = $getSettings->fetch();
    
    $title = "Пользователи";
    
    if(parent::isAjax()){
        
        
    }else{
    
    
    $countUsers = $this->db->query('SELECT * FROM ga_users');
    $countUsers = $countUsers->rowCount();
    

    $pagination = new Pagination();
    $per_page = 15;
    $result = $pagination->create(array('per_page' => $per_page, 'count' => $countUsers));
    
    $getUsers = $this->db->query('SELECT * FROM ga_users ORDER BY id DESC LIMIT '.$result['start'].', '.$per_page.'');
    $getUsers = $getUsers->fetchAll();
    
    $content = $this->view->renderPartial("control/users/index", ['users' => $getUsers, 'ViewPagination' => $result['ViewPagination']]);
 
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
    $sql = "DELETE FROM ga_users WHERE id =  :id";
    $stmt = $this->db->prepare($sql);
    $stmt->bindParam(':id', $id, PDO::PARAM_INT);   
    $stmt->execute();   

    }
    
        
    }
    
    
    public function actionEdit(){
    $user = new User();
    if(!$user->isAuth()){
        $this->actionLogin();
    }
    $getUserPrfile = $user->getProfile();
    if($getUserPrfile['role'] != 'admin')  parent::ShowError(404, "Страница не найдена!");

    if(isset($_GET['id'])) $id = (int)$_GET['id']; else $id = '';
    
    $title = "Изменение пользователя #$id";
     
    $getInfoUser = $this->db->prepare('SELECT * FROM ga_users WHERE id = :id');
    $getInfoUser->execute(array(':id' => $id));
    $getInfoUser = $getInfoUser->fetch();
    if(empty($getInfoUser)) parent::ShowError(404, "Страница не найдена!");
    
    
    if(parent::isAjax()){
    
    $firstname = $_POST['firstname'];
    $lastname = $_POST['lastname'];
    $email = $_POST['email'];
    $password = $_POST['password'];
    $role = $_POST['role'];
    $balance = (int)$_POST['balance'];
    
    if(isset($_POST['api_login'])) $api_login = $_POST['api_login']; else $api_login = '';
    
    $params = '';
    if(isset($_POST['api'])){
        $api = $_POST['api'];
        $params = json_encode(['key_api' => $api['key'], 'discount_api' => $api['discount']]);
        }

    
    
    $sql = "UPDATE ga_users SET firstname = :firstname, lastname = :lastname, email = :email, password = :password, role = :role, balance = :balance, params = :params, api_login = :api_login WHERE id = :id";
    $update = $this->db->prepare($sql);                                        
    $update->bindParam(':firstname', $firstname);   
    $update->bindParam(':lastname', $lastname); 
    $update->bindParam(':email', $email); 
    $update->bindParam(':password', $password); 
    $update->bindParam(':role', $role); 
    $update->bindParam(':balance', $balance); 
    $update->bindParam(':api_login', $api_login); 
    $update->bindParam(':params', $params); 
    $update->bindParam(':id', $id); 
    $update->execute();     
    
    $answer['status'] = "success";
    $answer['success'] = "Пользователь успешно изменен";
    exit(json_encode($answer)); 
        
    }else{
        
    $api_params = json_decode($getInfoUser['params'], true);
    $content = $this->view->renderPartial("control/users/edit", ['data' => $getInfoUser, 'api_params' => $api_params]);
 
    $this->view->render("control/main", ['content' => $content, 'title' => $title]);   
    
    }
    }
    
}