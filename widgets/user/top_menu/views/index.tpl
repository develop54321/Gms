<?php if($is_auth):?>
<div class="text-end">
    <a href="/user" class="btn btn-outline-light me-2"><?=$is_auth['email'];?></a>
    <a href="/user/logout" class="btn btn-warning">Выход</a>
</div>
<?php else:?>
    <div class="text-end">
        <a href="/user" class="btn btn-outline-light">Личный кабинет</a>
    </div>
<?php endif;?>
