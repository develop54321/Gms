<a href="/" class="site-logo">
    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><rect x="3" y="4" width="18" height="6" rx="1.5"/><rect x="3" y="14" width="18" height="6" rx="1.5"/><circle cx="7" cy="7" r="1" fill="currentColor" stroke="none"/><circle cx="7" cy="17" r="1" fill="currentColor" stroke="none"/></svg>
    <span>GMS</span>
</a>

<ul class="nav col-12 col-lg-auto me-lg-auto mb-2 mb-lg-0 justify-content-center">
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

<form action="/search" method="post" class="col-12 col-lg-auto mb-2 mb-lg-0 me-lg-3">
    <div class="search-pill">
        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="11" cy="11" r="7"/><path d="M21 21l-4.3-4.3"/></svg>
        <input type="search" name="query" placeholder="Поиск сервера..." aria-label="Поиск">
        <button type="submit" class="btn btn-light btn-sm">Найти</button>
    </div>
</form>

<?php if($userData):?>
<div class="text-end d-flex gap-2">
    <a href="/user" class="btn btn-outline-light">Личный кабинет</a>
    <a href="/user/logout" class="btn btn-logout">Выход</a>
</div>
<?php else:?>
    <div class="text-end">
        <a href="/user" class="btn btn-lk">Личный кабинет</a>
    </div>
<?php endif;?>
