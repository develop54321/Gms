<?php if ($status == 'expects'):?>
<label class="badge bg-warning">Ожидает платежа</label>
<?php elseif ($status == 'paid'):?>
<label class="badge bg-success">Оплаченный</label>
<?php elseif ($status == 'expired'):?>
<label class="badge bg-secondary">Истекший</label>
<?php endif;?>