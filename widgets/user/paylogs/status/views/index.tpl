<?php if ($status == 'expects'):?>
Ожидает платежа
<?php elseif ($status == 'paid'):?>
Оплачен
<?php elseif ($status == 'expired'):?>
Истекший
<?php endif;?>

