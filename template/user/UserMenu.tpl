<ul class="nav nav-pills menu-user">
  <li class="nav-item">
    <a class="nav-link m-1 <?php if($url == 'index'):?>active<?php endif;?>" href="/user">Профиль</a>
  </li>
  <li class="nav-item">
    <a class="nav-link m-1 <?php if($url == 'servers'):?>active<?php endif;?>" href="/user/servers">Мои сервера</a>
  </li>
  <li class="nav-item">
    <a class="nav-link m-1 <?php if($url == 'paylogs'):?>active<?php endif;?>" href="/user/paylogs">История платежей</a>
  </li>
    <li class="nav-item">
    <a class="nav-link m-1 <?php if($url == 'pay'):?>active<?php endif;?>" href="/user/pay">Пополнение счета</a>
  </li>
  <li class="nav-item">
    <a class="nav-link m-1" href="/user/logout">Выход</a>
  </li>
</ul>