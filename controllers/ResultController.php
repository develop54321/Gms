<?php

class ResultController extends BaseController{
    
    
    public function actionIndex(){
    $services = new Services();
    $user = new User();
    $getSettings = $this->db->query('SELECT * FROM ga_settings');
    $settings = $getSettings->fetch();
    
    if(isset($_GET['type'])) $type = $_GET['type']; else parent::ShowError(404, "Страница не найдена!");
    
    switch($type){
        case "robokassa":
        $real_out_summ = $_REQUEST["OutSum"];
        $out_summ = (int)$_REQUEST["OutSum"];
        $crc = strtoupper($_REQUEST["SignatureValue"]);
        $InvId = $_REQUEST["InvId"];  
        
        $typeCode = 'robokassa'; 
        $getInfoPayment = $this->db->prepare('SELECT * FROM ga_pay_methods WHERE typeCode = :typeCode');
        $getInfoPayment->execute(array(':typeCode' => $typeCode));
        $getInfoPayment = $getInfoPayment->fetch();
        $getInfoPayment = json_decode($getInfoPayment['content'], true);
        
        $getInfoPay = $this->db->prepare('SELECT * FROM ga_pay_logs WHERE id = :id');
        $getInfoPay->execute(array(':id' => $InvId));
        $getInfoPay = $getInfoPay->fetch();
        $getInfoPay = json_decode($getInfoPay['content'], true);
    
        $my_crc = strtoupper(md5("$real_out_summ:$InvId:".$getInfoPayment['password2'].""));
        if ($my_crc != $crc) exit("error po");
        
        if($getInfoPay['type_pay'] == 'refill'){
        $user->refill(['inv_id' => $InvId, 'amout' => $out_summ]);   
        }else{
        $services->checkService(['inv_id' => $InvId, 'price' => $out_summ, 'pay_methods' => $typeCode]);
        }
        echo "OK$InvId\n";
        
        
        break;
        
        
        case "unitpay":
        $request = $_GET;
        
        if (empty($request['method']) || empty($request['params']) || !is_array($request['params'])){
            exit(json_encode(array(
            "error" => array(
                "message" => "eror empty query"
            )
        )));
        }
        
        $method = $request['method'];
        $params = $request['params'];  
        $InvId = $params['account'];
         
        $typeCode = 'unitpay'; 
        $getInfoPayment = $this->db->prepare('SELECT * FROM ga_pay_methods WHERE typeCode = :typeCode');
        $getInfoPayment->execute(array(':typeCode' => $typeCode));
        $getInfoPayment = $getInfoPayment->fetch();
        $getInfoPayment = json_decode($getInfoPayment['content'], true);
        
        $getInfoPay = $this->db->prepare('SELECT * FROM ga_pay_logs WHERE id = :id');
        $getInfoPay->execute(array(':id' => $InvId));
        $getInfoPay = $getInfoPay->fetch();
        $getInfoPay = json_decode($getInfoPay['content'], true);
        

        $sign = $params['signature'];
        $out_summ = $params['sum'];
        $delimiter = '{up}';
        ksort($params);
        unset($params['sign']);
        unset($params['signature']);

        $check= hash('sha256', $method.$delimiter.join($delimiter, $params).$delimiter.$getInfoPayment['secret_key']);
    
        if ($sign != $check)
        {
           exit(json_encode(array(
            "error" => array(
                "message" => "eror hash"
            )
        )));
        }
        
        if($getInfoPay['type_pay'] == 'refill'){
        $user->refill(['inv_id' => $InvId, 'amout' => $out_summ]);   
        }else{
        $services->checkService(['inv_id' => $InvId, 'price' => $out_summ, 'pay_methods' => $typeCode]);
        }
        
        
        if($method == 'pay'){
            exit(json_encode(array("result" => array(
        	"message"=> "ok деньги зачислены"
            ), 
        )));   
        }else{
            
        $checkPay = $this->db->prepare('SELECT * FROM ga_pay_logs WHERE id = :id');
        $checkPay->bindValue(":id", $InvId);
        $checkPay->execute();
        if($checkPay->rowCount() == '0'){
        exit(json_encode(array("error" => array("message"=> "Pay not found"),)));    
        }
            
        exit(json_encode(array("result" => array("message"=> "check"),)));        
        }
           
        
      
    
   
    }
  
    }
    
    public function actionSuccess(){
        $title = "Оплата успешно прошла";
        $content = $this->view->renderPartial("pay/success");
    
        $this->view->render("main", ['content' => $content, 'title' => $title]);
    }
    
    public function actionFail(){
        $title = "Ошибка платежа";
        $content = $this->view->renderPartial("pay/fail");
    
        $this->view->render("main", ['content' => $content, 'title' => $title]);
    }
    
    
    
    
        
    
    
}