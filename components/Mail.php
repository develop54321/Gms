<?php
class Mail extends BaseController{

function send($to, $subject, $message){
$site_name = $_SERVER['SERVER_NAME'];

$headers  = 'MIME-Version: 1.0' . "\r\n";
$headers .= 'Content-type: text/html; charset=iso-8859-1' . "\r\n";


$headers .= 'From:  '.$site_name.' <support@'.$site_name.'>' . "\r\n";

mail($to, $subject, $message, $headers);
}
    
}