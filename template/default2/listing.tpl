<?php
use components\System;
?>

<section class="page">
    <div class="container">
        <h1 class="content-title">Листинг серверов</h1>
        <hr/>

        <span class="float-right">Текущее время: <?= date('d.m.Y [H:i]') ?></span>

        <table class="table table-dark">
            <thead>
            <tr>
                <th>Услуга</th>
                <th>Описание</th>
                <th class="text-center">Свободные места</th>
                <th class="text-center">Ближайшее место</th>
            </tr>
            </thead>
            <tbody>
            <?php if ($settings['global_settings']['top_on'] == 1): ?>
                <tr>
                    <td>Премиум место</td>
                    <td>Сервер находится в шапке на главной странице мониторинга</td>
                    <td class="text-center">
                        <?= $free_servers_top ?> из <?= $settings['global_settings']['count_servers_top'] ?>
                    </td>
                    <td class="text-center"><?= $free_date_top ?></td>
                </tr>
            <?php endif; ?>

            <?php if ($settings['global_settings']['boost_on'] == 1): ?>
                <tr>
                    <td>BOOST</td>
                    <td>Самый быстрый способ поднять онлайн на сервере</td>
                    <td class="text-center">
                        <?= $free_servers_boost ?> из <?= $settings['global_settings']['count_servers_boost'] ?>
                    </td>
                    <td class="text-center">Вытеснение</td>
                </tr>
            <?php endif; ?>

            <?php if ($settings['global_settings']['vip_on'] == 1): ?>
                <tr>
                    <td>VIP статус</td>
                    <td>Сервер находится вверху списка и имеет статус VIP</td>
                    <td class="text-center">
                        <?= $free_servers_vip ?> из <?= $settings['global_settings']['count_servers_vip'] ?>
                    </td>
                    <td class="text-center"><?= $free_date_vip ?></td>
                </tr>
            <?php endif; ?>

            <?php if ($settings['global_settings']['color_on'] == 1): ?>
                <tr>
                    <td>Выделение цветом</td>
                    <td>Выделяет ваш сервер в общем списке выбранным цветом</td>
                    <td class="text-center">
                        <?= $free_servers_color ?> из <?= $settings['global_settings']['count_servers_color'] ?>
                    </td>
                    <td class="text-center"><?= $free_date_color ?></td>
                </tr>
            <?php endif; ?>

            <?php if ($settings['global_settings']['gamemenu_on'] == 1): ?>
                <tr>
                    <td>GameMenu</td>
                    <td>Сервер добавляется в игровое меню клиента игры</td>
                    <td class="text-center">
                        <?= $free_servers_game_menu ?> из <?= $settings['global_settings']['count_servers_gamemenu'] ?>
                    </td>
                    <td class="text-center"><?= $free_date_game_menu ?></td>
                </tr>
            <?php endif; ?>
            </tbody>
        </table>

        <div>
            <?php if ($settings['global_settings']['top_on'] == 1): ?>
                <h5>Премиум место</h5>
                <table class="table table-dark">
                    <thead>
                    <tr>
                        <th>#</th>
                        <th>Название сервера</th>
                        <th>Адрес</th>
                        <th>Карта</th>
                        <th>Оплачено до</th>
                    </tr>
                    </thead>
                    <tbody>
                    <?php foreach ($topServers as $t): ?>
                        <tr>
                            <td width="3%"><?= $t['id_position'] ?></td>
                            <td width="32%" class="text-truncate" style="max-width: 260px;">
                                <a href="/server/<?= $t['ip'] ?>:<?= $t['port'] ?>/info">
                                    <?= htmlspecialchars($t['hostname']) ?>
                                </a>
                            </td>
                            <td width="20%">
                                <span class="address"><?= $t['ip'] ?>:<?= $t['port'] ?></span>
                            </td>
                            <td width="18%"><?= htmlspecialchars($t['map']) ?></td>
                            <td width="15%"><?= date('d.m.Y [H:i]', $t['top_expired_date']) ?></td>
                        </tr>
                    <?php endforeach; ?>

                    <?php if ($countTopServers < 1): ?>
                        <tr>
                            <td colspan="6" class="text-center">Список серверов пуст</td>
                        </tr>
                    <?php endif; ?>
                    </tbody>
                </table>
            <?php endif; ?>

            <?php if ($settings['global_settings']['boost_on'] == 1): ?>
                <h5>Буст</h5>
                <table class="table table-dark">
                    <thead>
                    <tr>
                        <th>#</th>
                        <th>Название сервера</th>
                        <th>Адрес</th>
                        <th>Карта</th>
                        <th>К-во кругов</th>
                    </tr>
                    </thead>
                    <tbody>
                    <?php $i = 1; foreach ($boostServers as $b): ?>
                        <tr>
                            <td width="3%"><?= $i ?></td>
                            <td width="32%" class="text-truncate" style="max-width: 260px;">
                                <a href="/server/<?= $b['ip'] ?>:<?= $b['port'] ?>/info">
                                    <?= htmlspecialchars($b['hostname']) ?>
                                </a>
                            </td>
                            <td width="20%">
                                <span class="address"><?= $b['ip'] ?>:<?= $b['port'] ?></span>
                            </td>
                            <td width="18%"><?= htmlspecialchars($b['map']) ?></td>
                            <td width="15%"><?= $b['boost'] ?></td>
                        </tr>
                        <?php $i++; ?>
                    <?php endforeach; ?>

                    <?php if ($countBoostServers < 1): ?>
                        <tr>
                            <td colspan="6" class="text-center">Список серверов пуст</td>
                        </tr>
                    <?php endif; ?>
                    </tbody>
                </table>
            <?php endif; ?>

            <?php if ($settings['global_settings']['vip_on'] == 1): ?>
                <h5>VIP СТАТУС</h5>
                <table class="table table-dark">
                    <thead>
                    <tr>
                        <th>#</th>
                        <th>Название сервера</th>
                        <th>Адрес</th>
                        <th>Карта</th>
                        <th>Оплачено до</th>
                    </tr>
                    </thead>
                    <tbody>
                    <?php $i = 1; foreach ($vipServers as $v): ?>
                        <tr>
                            <td width="3%"><?= $i ?></td>
                            <td width="32%" class="text-truncate" style="max-width: 260px;">
                                <a href="/server/<?= $v['ip'] ?>:<?= $v['port'] ?>/info">
                                    <?= htmlspecialchars($v['hostname']) ?>
                                </a>
                            </td>
                            <td width="20%">
                                <span class="address"><?= $v['ip'] ?>:<?= $v['port'] ?></span>
                            </td>
                            <td width="18%"><?= htmlspecialchars($v['map']) ?></td>
                            <td width="15%"><?= date('d.m.Y [H:i]', $v['vip_expired_date']) ?></td>
                        </tr>
                        <?php $i++; ?>
                    <?php endforeach; ?>

                    <?php if ($countVipServers < 1): ?>
                        <tr>
                            <td colspan="6" class="text-center">Список серверов пуст</td>
                        </tr>
                    <?php endif; ?>
                    </tbody>
                </table>
            <?php endif; ?>

            <?php if ($settings['global_settings']['color_on'] == 1): ?>
                <h5>Выделение цветом</h5>
                <table class="table table-dark">
                    <thead>
                    <tr>
                        <th>#</th>
                        <th>Название сервера</th>
                        <th>Адрес</th>
                        <th>Карта</th>
                        <th>Оплачено до</th>
                    </tr>
                    </thead>
                    <tbody>
                    <?php $i = 1; foreach ($colorServers as $c): ?>
                        <tr>
                            <td width="3%"><?= $i ?></td>
                            <td width="32%" class="text-truncate" style="max-width: 260px;">
                                <a href="/server/<?= $c['ip'] ?>:<?= $c['port'] ?>/info">
                                    <?= htmlspecialchars($c['hostname']) ?>
                                </a>
                            </td>
                            <td width="20%">
                                <span class="address"><?= $c['ip'] ?>:<?= $c['port'] ?></span>
                            </td>
                            <td width="18%"><?= htmlspecialchars($c['map']) ?></td>
                            <td width="15%"><?= date('d.m.Y [H:i]', $c['color_expired_date']) ?></td>
                        </tr>
                        <?php $i++; ?>
                    <?php endforeach; ?>

                    <?php if ($countColorServers < 1): ?>
                        <tr>
                            <td colspan="6" class="text-center">Список серверов пуст</td>
                        </tr>
                    <?php endif; ?>
                    </tbody>
                </table>
            <?php endif; ?>

            <?php if ($settings['global_settings']['gamemenu_on'] == 1): ?>
                <h5>GameMenu</h5>
                <table class="table table-dark">
                    <thead>
                    <tr>
                        <th>#</th>
                        <th>Название сервера</th>
                        <th>Адрес</th>
                        <th>Карта</th>
                        <th>Оплачено до</th>
                    </tr>
                    </thead>
                    <tbody>
                    <?php $i = 1; foreach ($gamemenuServers as $g): ?>
                        <tr>
                            <td width="3%"><?= $i ?></td>
                            <td width="32%" class="text-truncate" style="max-width: 260px;">
                                <a href="/server/<?= $g['ip'] ?>:<?= $g['port'] ?>/info">
                                    <?= htmlspecialchars($g['hostname']) ?>
                                </a>
                            </td>
                            <td width="20%">
                                <span class="address"><?= $g['ip'] ?>:<?= $g['port'] ?></span>
                            </td>
                            <td width="18%"><?= htmlspecialchars($g['map']) ?></td>
                            <td width="15%"><?= date('d.m.Y [H:i]', $g['gamemenu_expired_date']) ?></td>
                        </tr>
                        <?php $i++; ?>
                    <?php endforeach; ?>

                    <?php if ($countGamemenuServers < 1): ?>
                        <tr>
                            <td colspan="6" class="text-center">Список серверов пуст</td>
                        </tr>
                    <?php endif; ?>
                    </tbody>
                </table>
            <?php endif; ?>
        </div>
    </div>
</section>