<form method="GET" action='http://www.free-kassa.ru/merchant/cash.php' target="_blank">
	<input type="hidden" name="m" value="<?=$InfoPayment['fk_id'];?>" />
	<input type="hidden" name="oa" value="<?=$price;?>" />
	<input type="hidden" name="o" value="<?=$payId;?>" />
	<input type="hidden" name="s" value="<?=$signfk;?>" />
	<input type="submit" class="btn btn-success btn-sm" value="Оплатить Free-Kassa"/>
</form>