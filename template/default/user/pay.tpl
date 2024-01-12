<div class="content">
<nav aria-label="breadcrumb">
  <ol class="breadcrumb">
    <li class="breadcrumb-item"><a href="/">Главная</a></li>
    <li class="breadcrumb-item active" aria-current="page">Пополнение счета</li>
  </ol>
</nav>


<?php $url = "pay"; include("UserMenu.tpl");?>
    <?php echo widgets\flash\Flash::run();?>
<?php if($step == '1'):?>
<form action="#" method="post">

<table class="table">
<tr>
<td colspan="2">    
<div class="form-group">
<label>Выберите способ оплаты</label>
<select class="form-control form-control-sm" name="typePayment">
<?php foreach($PayMethods as $pm):?>
<option value="<?php echo $pm['id'];?>"><?php echo $pm['name'];?></option>
<?php endforeach;?>
</select>
</div>
</td>


<td>
<div class="form-group">
<label>Введите сумму пополнения</label>
<input type="number" name="amout" class="form-control form-control-sm" required="">
 </div>      
</td>
</tr>

<tr>
<td style="border: none;"><input type="submit" class="btn btn-primary btn-sm" value="Далее"/></td>
</tr>
</table>


</form>
<?php elseif($step == '2'):?>
<?php
$desc = "Пополнение счета  #".$user_profile['id']."";
if($InfoPayment['typeCode'] == 'robokassa'){
$crc  = md5("".$InfoPayment['login'].":".$amount.":$payId:".$InfoPayment['password1']."");
}elseif($InfoPayment['typeCode'] == 'freekassa'){
$signfk = md5($InfoPayment['fk_id'].":".$amount.":".$InfoPayment['fk_key1'].":".$payId);
}elseif($InfoPayment['typeCode'] == 'unitpay'){
$hashStr = $payId.'{up}'.$desc.'{up}'.$amount.'{up}'.$InfoPayment['secret_key'];
$hash = hash('sha256', $hashStr);
}

$price = $amount;
?> 
<?php include(TMPL_DIR."/pay/".$InfoPayment['typeCode'].".tpl");?>

<?php endif;?>

</div>