<?php if($step == '1'):?>


<?php if($type == 'befirst'):?>
<?php if($serverInfo['befirst_enabled'] == '0'):?>
 <div class="form-row mt-3">
<div class="col-md-5">
<div id="contentForm"></div>
<h4>Выберите место в Будь Первым</h4>
<?php foreach($databefirst as $row):?>
    
<?php if($row['status'] == '0'):?>
<div class="custom-control custom-radio">
  <input type="radio" id="place<?php echo $row['id'];?>" name="place" class="custom-control-input" value="<?php echo $row['id'];?>" required="">
  <label class="custom-control-label" for="place<?php echo $row['id'];?>">Место #<?php echo $row['id'];?> свободно</label>
</div>
<?php else:?>
<div class="custom-control custom-radio">
  <input type="radio" class="custom-control-input" disabled="">
  <label class="custom-control-label">Место #<?php echo $row['id'];?> занято</label>
</div>
<?php endif;?>

<?php endforeach;?>
</div>
</div>
<?php endif;?>


<?php elseif($type == 'top'):?>
<?php if($serverInfo['top_enabled'] == '0'):?>
 <div class="form-row mt-3">
<div class="col-md-5">
<div id="contentForm"></div>
<h4>Выберите место в топе</h4>
<?php foreach($datatop as $row):?>
    
<?php if($row['status'] == '0'):?>
<div class="custom-control custom-radio">
  <input type="radio" id="place<?php echo $row['id'];?>" name="place" class="custom-control-input" value="<?php echo $row['id'];?>" required="">
  <label class="custom-control-label" for="place<?php echo $row['id'];?>">Место #<?php echo $row['id'];?> свободно</label>
</div>
<?php else:?>
<div class="custom-control custom-radio">
  <input type="radio" class="custom-control-input" disabled="">
  <label class="custom-control-label">Место #<?php echo $row['id'];?> занято</label>
</div>
<?php endif;?>

<?php endforeach;?>
</div>
</div>
<?php endif;?>


<?php elseif($type == 'color'):?>

<div class="form-row mt-3">
<div class="col-md-5">


<?php foreach($CodeColors as $row):?>
<div class="custom-control custom-radio">
  <input type="radio" id="colorBlue<?php echo $row['code'];?>" name="selectColor" class="custom-control-input" value="<?php echo $row['code'];?>">
  <label class="custom-control-label" for="colorBlue<?php echo $row['code'];?>">
  <div class="example-color" style="background: <?php echo $row['code'];?>;"></div><?php echo $row['name'];?></label>
</div>
<?php endforeach;?>



</div>
</div>

<?php elseif($type == 'razz'):?>
<?php if($serverInfo['ban'] == '0'):?>
Вы не можете купить эту услугу, так как сервер не находится в бане.
<?php endif;?>

<?php endif;?>

<?php if(isset($type)):?>

<div class="form-row mt-3">
<div class="col-md-5">
<h4>Выберите способ оплаты</h4>
<select class="form-control form-control-sm" name="typePayment">
<?php foreach($PayMethods as $pm):?>
<option value="<?php echo $pm['id'];?>"><?php echo $pm['name'];?></option>
<?php endforeach;?>
</select>
</div>
</div>

<div class="form-row mt-3">
<div class="col-md-5">
<h4>Стоимость: <?php echo $infoServices['price'];?> руб.</h4>
</div>
</div>



<div class="form-row mt-3">
<div class="col-md-5">
<button type="submit" class="btn btn-success btn-sm">Далее</button>
</div>
</div>
<?php endif;?>


<?php elseif($step == '2'):?>
<div class="content">

<nav aria-label="breadcrumb">
  <ol class="breadcrumb">
    <li class="breadcrumb-item"><a href="/">Главная</a></li>
    <li class="breadcrumb-item active" aria-current="page">Платные услуги</li>
  </ol>
</nav>
<?php
$price = $infoServices['price'];
$desc = "Оплата услуги  #".$infoServices['id']."";
if($InfoPayment['typeCode'] == 'robokassa'){
$crc  = md5("".$InfoPayment['login'].":".$price.":$payId:".$InfoPayment['password1']."");
}elseif($InfoPayment['typeCode'] == 'unitpay'){
$hashStr = $payId.'{up}'.$desc.'{up}'.$infoServices['price'].'{up}'.$InfoPayment['secret_key'];
$hash=hash('sha256', $hashStr);
}elseif($InfoPayment['typeCode'] == 'freekassa'){
$signfk = md5($InfoPayment['fk_id'].":".$price.":".$InfoPayment['fk_key1'].":".$payId);
}
?>
<?php include("pay/".$InfoPayment['typeCode'].".tpl");?>
</div>
<?php endif;?>