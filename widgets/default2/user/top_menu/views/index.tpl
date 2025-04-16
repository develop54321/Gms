<div class="d-flex flex-wrap align-items-center justify-content-center justify-content-lg-start">
    <a href="/" class="d-flex align-items-center mb-2 mb-lg-0 text-decoration-none text-white">
        <b>GMS</b>
    </a>

    <ul class="nav col-12 col-lg-auto me-lg-auto mb-2 justify-content-center mb-md-0">
        <?php if ($userData):?>
            <?php if ($userData['role'] === "admin"):?>
                <li><a href="/control" class="nav-link px-2" target="_blank"><b>Панель управления</b></a></li>
            <?php endif;?>
        <?php endif;?>


        <li><a href="/server/add" class="nav-link px-2">Добавить сервер</a></li>
        <li><a href="/news" class="nav-link px-2">Новости</a></li>
        <li><a href="/listing" class="nav-link px-2">Листинг</a></li>
        <li><a href="/pay" class="nav-link px-2">Услуги</a></li>
        <li><a href="/banlist" class="nav-link px-2">Банлист</a></li>
        <li><a href="/page/1" class="nav-link px-2">Контакты</a></li>
    </ul>

    <form action="/search" method="post" class="col-12 col-lg-auto mb-3 mb-lg-0 me-lg-3">
        <div class="input-group">
            <input type="search" class="form-control form-control-dark form-control-sm" name="query" placeholder="Поиск..." aria-label="Поиск">
            <button type="submit" class="btn btn-light">Найти</button>
        </div>
    </form>

<?php if($userData):?>
<div class="text-end">
    <a href="/user" class="btn btn-outline-light me-2">Личный кабинет</a>
    <a href="/user/logout" class="btn btn-logout">Выход</a>
</div>
<?php else:?>
    <div class="text-end">
        <a href="/user" class="btn btn-lk">Личный кабинет</a>
    </div>
<?php endif;?>


</div>