<div class="list-group">
    <a href="/user" class="list-group-item list-group-item-action d-flex align-items-center <?php if($url == 'index'):?>active<?php endif;?>">
        <i class="fa fa-user-circle me-3"></i>
        <span>Профиль</span>
    </a>

    <a href="/user/security" class="list-group-item list-group-item-action d-flex align-items-center <?php if($url == 'security'):?>active<?php endif;?>">
        <i class="fa fa-shield me-3"></i>
        <span>Безопасность</span>
    </a>

    <a href="/user/servers" class="list-group-item list-group-item-action d-flex align-items-center <?php if($url == 'servers'):?>active<?php endif;?>">
        <i class="fa fa-server me-3"></i>
        <span>Мои сервера</span>
    </a>

    <a href="/user/pay-logs" class="list-group-item list-group-item-action d-flex align-items-center <?php if($url == 'paylogs'):?>active<?php endif;?>">
        <i class="fa fa-history me-3"></i>
        <span>История платежей</span>
    </a>

    <a href="/user/pay" class="list-group-item list-group-item-action d-flex align-items-center <?php if($url == 'pay'):?>active<?php endif;?>">
        <i class="fa fa-credit-card me-3"></i>
        <span>Пополнение счета</span>
    </a>

    <a href="/user/promo" class="list-group-item list-group-item-action d-flex align-items-center <?php if($url == 'promo'):?>active<?php endif;?>">
        <i class="fa fa-ticket me-3"></i>
        <span>Промокод</span>
    </a>

    <a href="/user/logout" class="list-group-item list-group-item-action d-flex align-items-center text-danger">
        <i class="fa fa-sign-out me-3"></i>
        <span>Выход</span>
    </a>
</div>