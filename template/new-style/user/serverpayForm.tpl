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


<?php endif;?>

<?php if(isset($type)):?>

<div class="form-row mt-3">
<div class="col-md-5">
<h4>Выберите способ оплаты</h4>
<select class="form-control form-control-sm" name="typePayment">
<option value="balance">Лицевой счет - <?php echo $user_profile['balance'];?>р.</option>

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
<button type="submit" class="btn btn-success btn-sm">Оплатить</button>
</div>
</div>
<?php endif;?>


<?php elseif($step == '2'):?>
<?php $price = $infoServices['price'];?>
<?php include("pay/".$InfoPayment['typeCode'].".tpl");?>
<?php endif;?>