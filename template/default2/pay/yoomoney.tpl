<form method="get" action='https://yoomoney.ru/quickpay/confirm.xml' target="_blank">
    <input type="hidden" name="receiver" value="<?php echo $InfoPayment['receiver'];?>" />
    <input type="hidden" name="quickpay-form" value="donate" />
    <input type="hidden" name="targets" value="<?=$desc;?>" />
    <input type="hidden" name="sum" value="<?=$price;?>" />
    <input type="hidden" name="label" value="<?=$payId;?>" />
    <input type="hidden" name="successURL" value="<?php echo BASE_URL . "/result/success";?>" />
    <input type="submit" class="btn btn-success btn-sm" value="Оплатить YooMoney"/>
</form>