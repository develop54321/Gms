<form action='https://merchant.roboxchange.com/Index.aspx' method="POST" target="_blank">
<input type="hidden" name="MrchLogin" value="<?php echo $InfoPayment['login'];?>">
<input type="hidden" name="OutSum" value="<?php echo $price;?>">
<input type="hidden" name="InvId" value="<?php echo $payId;?>">
<input type="hidden" name="Desc" value="<?php echo $desc;?>">
<input type="hidden" name="Signature" value="<?=$crc;?>"> 
<input type="submit" class="btn btn-success btn-sm" value="Оплатить Robokassa"/>
</form>