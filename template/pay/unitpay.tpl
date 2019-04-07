<form action="https://unitpay.ru/pay/<?echo $InfoPayment['public_key'];?>" target="_blank">
<input type="hidden" name="sum" value="<?php echo $price;?>" />
<input type="hidden" name="account" value="<?php echo $payId;?>" />
<input type="hidden" name="desc" value="<?php echo $desc;?>" />
<input type="hidden" name="signature" value="<?php echo $hash;?>" />
<input type="submit" class="btn btn-success btn-sm" value="Оплатить UnitPay"/>
</form>