<section class="page">
    <div class="container">
        <h1 class="content-title">
            Личный кабинет
        </h1>
        <hr/>


            <div class="row">

                <div class="col-md-2">
                    <?php $url = "index";
                    include("UserMenu.tpl"); ?>

                </div>

                <div class="col-md-10">
                    <div class="balance-card">
                        <div>
                            <div class="label">Баланс счета</div>
                            <div class="amount"><?php echo \widgets\money\Money::run($user_profile['balance']); ?></div>
                        </div>
                        <a class="btn btn-primary btn-sm" href="/user/pay">Пополнить</a>
                    </div>

                    <div class="card">
                        <h3>Профиль</h3>
                        <ul class="list-group profile-list">
                            <li class="list-group-item"><span class="label">Имя</span> <span class="value"><?php echo $user_profile['firstname']; ?></span></li>
                            <li class="list-group-item"><span class="label">Фамилия</span> <span class="value"><?php echo $user_profile['lastname']; ?></span></li>
                            <li class="list-group-item"><span class="label">E-mail</span> <span class="value"><?php echo $user_profile['email']; ?></span></li>
                            <li class="list-group-item"><span class="label">Статус</span> <span class="value"><?php widgets\user\status\Status::run($user_profile['role']); ?></span></li>

                            <?php if ($user_profile['role'] == 'partner'): ?>
                                <li class="list-group-item"><span class="label">Размер скидки</span> <span class="value"><?php echo $user_profile['discount_api']; ?>%</span></li>
                                <li class="list-group-item"><span class="label">Расход за текущий месяц</span> <span class="value"><?php echo \widgets\money\Money::run($sumMonth); ?></span></li>
                            <?php endif; ?>
                        </ul>
                    </div>
                </div>



        </div>
    </div>
</section>

