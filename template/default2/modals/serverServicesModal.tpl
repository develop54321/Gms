<div class="modal" id="serverServicesModal" tabindex="-1">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Услуги сервера - #<?php echo $data['id']; ?></h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <p>


                    </li>
                    <li><?php if ($data['top_enabled'] != '0'): ?>
                            TOP - место #<?php echo $data['top_enabled']; ?> | истекает: <?php echo date("d.m.Y [H:i]", $data['top_expired_date']); ?>
                        <?php else: ?>
                            TOP: <a href="/pay/<?php echo $data['id']; ?>/select">Купить</a>
                        <?php endif; ?>
                    </li>
                    <li>
                        <?php if ($data['boost'] != '0'): ?>
                            Boost: осталось кругов: <?php echo $data['boost']; ?> <a
                                    href="/pay/<?php echo $data['id']; ?>/select">Купить</a>
                        <?php else: ?>
                            Boost: <a href="/pay/<?php echo $data['id']; ?>/select">Купить</a>
                        <?php endif; ?>
                    </li>
                    <li><?php if ($data['vip_enabled'] != '0'): ?>
                            VIP: истекает: <?php echo date("d.m.Y [H:i]", $data['vip_expired_date']); ?>
                        <?php else: ?>
                            VIP: <a href="/pay/<?php echo $data['id']; ?>/select">Купить</a>
                        <?php endif; ?>
                    </li>
                    <li><?php if ($data['color_enabled'] != '0'): ?>
                            Выделение цветом: истекает: <?php echo date("d.m.Y [H:i]", $data['color_expired_date']); ?>
                        <?php else: ?>
                            Выделение цветом: <a href="/pay/<?php echo $data['id']; ?>/select">Купить</a>
                        <?php endif; ?>
                    </li>
                    <li><?php if ($data['gamemenu_enabled'] != '0'): ?>
                            GameMenu: истекает: <?php echo date("d.m.Y [H:i]", $data['gamemenu_expired_date']); ?>
                        <?php else: ?>
                            GameMenu: <a href="/pay/<?php echo $data['id']; ?>/select">Купить</a>
                        <?php endif; ?>
                    </li>


                </p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-outline-danger btn-sm" data-bs-dismiss="modal">Закрыть</button>
            </div>
        </div>
    </div>
</div>