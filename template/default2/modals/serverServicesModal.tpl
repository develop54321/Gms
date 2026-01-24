<div class="modal" id="serverServicesModal" tabindex="-1">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Услуги сервера - #<?php echo $data['id']; ?></h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <ul>
                    <li><?php if ($data['top_enabled'] !== null): ?>
                        TOP - место #<?php echo $data['top_enabled']; ?> |
                        истекает: <?php echo date("d.m.Y [H:i]", $data['top_expired_date']); ?>
                        <?php else: ?>
                        TOP: <a href="/pay/<?php echo $data['id']; ?>/select">Купить</a>
                        <?php endif; ?>
                    </li>
                    <li>
                        <?php if ($data['boost'] !== null): ?>
                        Буст: осталось кругов: <?php echo $data['boost']; ?> <a
                                href="/pay/<?php echo $data['id']; ?>/select">Купить</a>
                        <?php else: ?>
                        Буст: <a href="/pay/<?php echo $data['id']; ?>/select">Купить</a>
                        <?php endif; ?>
                    </li>
                    <li><?php if ($data['vip_enabled'] !== null): ?>
                        VIP: истекает: <?php echo date("d.m.Y [H:i]", $data['vip_expired_date']); ?>
                        <?php else: ?>
                        VIP: <a href="/pay/<?php echo $data['id']; ?>/select">Купить</a>
                        <?php endif; ?>
                    </li>
                    <li><?php if ($data['color_enabled'] !== null): ?>
                        Выделение цветом: истекает: <?php echo date("d.m.Y [H:i]", $data['color_expired_date']); ?>
                        <?php else: ?>
                        Выделение цветом: <a href="/pay/<?php echo $data['id']; ?>/select">Купить</a>
                        <?php endif; ?>
                    </li>
                    <li><?php if ($data['gamemenu_enabled'] !== null): ?>
                        GameMenu: истекает: <?php echo date("d.m.Y [H:i]", $data['gamemenu_expired_date']); ?>
                        <?php else: ?>
                        GameMenu: <a href="/pay/<?php echo $data['id']; ?>/select">Купить</a>
                        <?php endif; ?>
                    </li>
                </ul>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-outline-danger btn-sm" data-bs-dismiss="modal">Закрыть</button>
            </div>
        </div>
    </div>
</div>