<section class="content mt-5">
    <div class="container">
<nav aria-label="breadcrumb">
  <ol class="breadcrumb">
    <li class="breadcrumb-item"><a href="/">Главная</a></li>
    <li class="breadcrumb-item active" aria-current="page">Пополнение счета</li>
  </ol>
</nav>


<?php $url = "pay"; include("UserMenu.tpl");?>

<?php if($step == '1'):?>
<div class="row">
    <div class="col-md-4">
        <form action="#" method="post">
            <div class="mb-3">
                <label>Выберите способ оплаты</label>
                <select class="form-control form-control-sm" name="typePayment">
                    <?php foreach($PayMethods as $pm):?>
                    <option value="<?php echo $pm['id'];?>"><?php echo $pm['name'];?></option>
                    <?php endforeach;?>
                </select>
            </div>
            <div class="mb-3">
                <input type="number" name="amout" class="form-control form-control-sm" required="">
            </div>
            <button type="submit" class="btn btn-outline-primary">Далее</button>
        </form>

    </div>
</div>


<?php elseif($step == '2'):?>
<?php
$desc = "Пополнение счета  #".$user_profile['id']."";
if($InfoPayment['typeCode'] == 'robokassa'){
$crc  = md5("".$InfoPayment['login'].":".$amout.":$payId:".$InfoPayment['password1']."");
}elseif($InfoPayment['typeCode'] == 'freekassa'){
$signfk = md5($InfoPayment['fk_id'].":".$amout.":".$InfoPayment['fk_key1'].":".$payId);
}elseif($InfoPayment['typeCode'] == 'unitpay'){
$hashStr = $payId.'{up}'.$desc.'{up}'.$amout.'{up}'.$InfoPayment['secret_key'];
$hash = hash('sha256', $hashStr);
}

$price = $amout;
?> 
<?php include(TMPL_DIR."/pay/".$InfoPayment['typeCode'].".tpl");?>

<?php endif;?>

</div>
</section>