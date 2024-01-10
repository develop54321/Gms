<div class="content">
<nav aria-label="breadcrumb">
  <ol class="breadcrumb">
    <li class="breadcrumb-item"><a href="/">Главная</a></li>
    <li class="breadcrumb-item active" aria-current="page">Личный кабинет</li>
  </ol>
</nav>



<?php $url = "index"; include("UserMenu.tpl");?>

<div class="row">

<div class="w-100 m-4">
<ul class="list-group">
  <li class="list-group-item"><b>Ваше Имя:</b> <?php echo $user_profile['firstname'];?></li>
  <li class="list-group-item"><b>Ваше Фамилия:</b> <?php echo $user_profile['lastname'];?></li>
  <li class="list-group-item"><b>Ваш E-mail:</b> <?php echo $user_profile['email'];?></li>
  <li class="list-group-item"><b>Ваш счет:</b> <?php echo \widgets\money\Money::run($user_profile['balance']);?> [<a href="/user/pay" style="color: #0078b1;">Пополнить</a>]</li>
  <li class="list-group-item"><b>Ваш статус:</b> 
  <?php if($user_profile['role'] == 'user'):?>
  <span class="badge badge-warning">Пользователь</span>
  <?php elseif($user_profile['role'] == 'partner'):?>
  <span class="badge badge-info">Партнер</span>
  <?php elseif($user_profile['role'] == 'admin'):?>
  <span class="badge badge-success">Администратор</span>
  <?php endif;?></li>
  
  <?php if($user_profile['role'] == 'partner'):?>
  <li class="list-group-item"><b>Размер скидки:</b><?php echo $user_profile['discount_api'];?>%</li>
  <li class="list-group-item"><b>Расход за текущий месяц:</b><?php echo \widgets\money\Money::run($sumMonth);?>р.</li>
  <?php endif;?>
</ul>
</div>

</div>

</div>

