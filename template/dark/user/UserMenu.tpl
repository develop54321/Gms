<div class="list-group side-nav">
    <a href="/user" class="list-group-item list-group-item-action d-flex align-items-center <?php if($url == 'index'):?>active<?php endif;?>">
        <span class="nav-ico"><i class="fa fa-user-circle"></i></span>
        <span>Профиль</span>
    </a>

    <a href="/user/security" class="list-group-item list-group-item-action d-flex align-items-center <?php if($url == 'security'):?>active<?php endif;?>">
        <span class="nav-ico"><i class="fa fa-shield"></i></span>
        <span>Безопасность</span>
    </a>

    <a href="/user/servers" class="list-group-item list-group-item-action d-flex align-items-center <?php if($url == 'servers'):?>active<?php endif;?>">
        <span class="nav-ico"><i class="fa fa-server"></i></span>
        <span>Мои сервера</span>
    </a>

    <a href="/user/pay-logs" class="list-group-item list-group-item-action d-flex align-items-center <?php if($url == 'paylogs'):?>active<?php endif;?>">
        <span class="nav-ico"><i class="fa fa-history"></i></span>
        <span>История платежей</span>
    </a>

    <a href="/user/pay" class="list-group-item list-group-item-action d-flex align-items-center <?php if($url == 'pay'):?>active<?php endif;?>">
        <span class="nav-ico"><i class="fa fa-credit-card"></i></span>
        <span>Пополнение счета</span>
    </a>

    <a href="/user/promo" class="list-group-item list-group-item-action d-flex align-items-center <?php if($url == 'promo'):?>active<?php endif;?>">
        <span class="nav-ico"><i class="fa fa-ticket"></i></span>
        <span>Промокод</span>
    </a>

    <a href="/user/logout" class="list-group-item list-group-item-action d-flex align-items-center text-danger">
        <span class="nav-ico"><i class="fa fa-sign-out"></i></span>
        <span>Выход</span>
    </a>
</div>
