<?php if ($status == 'expects'):?>
<span class="text-warning">Ожидает платежа</span>
<?php elseif ($status == 'paid'):?>
<span class="text-success">Оплачен</span>
<?php elseif ($status == 'expired'):?>
<span class="text-danger">Истекший</span>
<?php endif;?>

