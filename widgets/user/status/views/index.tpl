<span class="badge bg-primary">
<?php if($role == 'user'):?>
Пользователь
<?php elseif($role == 'partner'):?>
Партнер
<?php elseif($role == 'admin'):?>
Администратор
<?php endif;?>
</span>