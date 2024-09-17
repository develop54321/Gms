<div class="list-group">
  <a href="/user" class="list-group-item list-group-item-action <?php if($url == 'index'):?>active<?php endif;?>" aria-current="true">Профиль</a>
  <a href="/user/servers" class="list-group-item list-group-item-action <?php if($url == 'servers'):?>active<?php endif;?>">Мои сервера</a>
  <a href="/user/pay-logs" class="list-group-item list-group-item-action <?php if($url == 'paylogs'):?>active<?php endif;?>">История платежей</a>
  <a href="/user/pay" class="list-group-item list-group-item-action <?php if($url == 'pay'):?>active<?php endif;?>">Пополнение счета</a>
  <a href="/user/logout" class="list-group-item list-group-item-action">Выход</a>
</div>