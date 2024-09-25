<?php
use components\System;
?>

<section class="page">
    <div class="container">
        <h1 class="content-title">
            Листинг серверов
        </h1>
        <hr/>


        <span style="float: right;">Текущее время: <?php echo date("d.m.Y [H:i]");?></span>
        <table class="table table-dark">
            <thead>
            <tr>
                <th>Услуга</th>
                <th>Описание</th>
                <th style="text-align: center;">Свободные места</th>
                <th style="text-align: center;">Ближайшее место</th>
            </tr>
            </thead>
            <tbody>

            <?php if($settings['global_settings']['top_on']==1):?>
            <tr>
                <td>Премиум место</td>
                <td>Сервер находится в шапке на главной странице мониторинга</td>
                <td class="text-center"><?php echo $free_servers_top;?>
                    из <?php echo $settings['global_settings']['count_servers_top'];?></td>
                <td class="text-center"><?php echo $free_date_top;?></td>
            </tr>
            <?php endif;?>
            <?php if($settings['global_settings']['boost_on']==1):?>
            <tr>
                <td>BOOST</td>
                <td>Самый быстрый способ поднять онлайн на сервере</td>
                <td class="text-center"><?php echo $free_servers_boost;?>
                    из <?php echo $settings['global_settings']['count_servers_boost'];?></td>
                <td class="text-center">Вытеснение</td>
            </tr>
            <?php endif;?>
            <?php if($settings['global_settings']['vip_on']==1):?>
            <tr>
                <td>VIP статус</td>
                <td>Сервер находится вверху списка и имеет статус VIP</td>
                <td class="text-center"><?php echo $free_servers_vip;?>
                    из <?php echo $settings['global_settings']['count_servers_vip'];?></td>
                <td class="text-center"><?php echo $free_date_vip;?></td>
            </tr>
            <?php endif;?>
            <?php if($settings['global_settings']['color_on']==1):?>
            <tr>
                <td>Выделение цветом</td>
                <td>Выделяет ваш сервер в общем списке выбранным цветом</td>
                <td class="text-center"><?php echo $free_servers_color;?>
                    из <?php echo $settings['global_settings']['count_servers_color'];?></td>
                <td class="text-center"><?php echo $free_date_color;?></td>
            </tr>
            <?php endif;?>
            <?php if($settings['global_settings']['gamemenu_on']==1):?>
            <tr>
                <td>GameMenu</td>
                <td>Сервер добавляется в игровое меню клиента игры</td>
                <td class="text-center"><?php echo $free_servers_game_menu;?>
                    из <?php echo $settings['global_settings']['count_servers_gamemenu'];?></td>
                <td class="text-center"><?php echo $free_date_game_menu;?></td>
            </tr>
            <?php endif;?>
            </tbody>
        </table>

        <div>
            <?php if($settings['global_settings']['top_on']==1):?>
            <h5>ПРЕМИУМ МЕСТО</h5>
            <table class="table table-dark">
                <thead>
                <tr>
                    <th>#</th>
                    <th>Название сервера</th>
                    <th>Адрес</th>
                    <th>Заполненость</th>
                    <th>Карта</th>
                    <th>Оплачено до</th>
                </tr>
                </thead>
                <tbody>
                <?php foreach($topServers as $t):?>
                <tr>
                    <td width="3%"><?php echo $t['id_position'];?></a></td>
                    <td width="32%"
                        style="white-space: nowrap;overflow: hidden;text-overflow: ellipsis;max-width: 260px;"><a
                                href="/server/<?php echo $t['ip'];?>:<?php echo $t['port'];?>/info"><?php echo $t['hostname'];?></a></td>
                    <td width="20%"><?php echo $t['ip'];?>
                        :<?php echo $t['port'];?></td>
                    <td width="12%">
                        <div class="uk-progress uk-progress-striped">
                            <div class="uk-progress-bar"
                                 style="width: <?php echo $t['show_players'];?>;"> <?php echo $t['show_players'];?></div>
                        </div>
                    </td>
                    <td width="18%"><?php echo $t['map'];?></td>
                    <td width="15%"><?php echo date("d.m.Y [H:i]", $t['top_expired_date']);?></td>
                </tr>
                <?php endforeach;
if($countTopServers<1):
?>
                <tr>
                    <td colspan="6" align="center">Список серверов пуст</td>
                </tr>
                <?php endif;?>
                </tbody>
            </table>
            <?php endif;?>


            <?php if($settings['global_settings']['boost_on']==1):?>
            <h5>BOOST</h5>

            <table class="table table-dark">
                <thead>
                <tr>
                    <th>#</th>
                    <th>Название сервера</th>
                    <th>Адрес</th>
                    <th>Заполненость</th>
                    <th>Карта</th>
                    <th>К-во кругов</th>
                </tr>
                </thead>
                <tbody>
                <?php $i = 1;
foreach($boostServers as $b):
$system = new System();
$show_playersBoost = $system->showbar( $b['players'], $b['max_players'] );
                ?>
                <tr>
                    <td width="3%"><?php echo $i;?></a></td>
                    <td width="32%"
                        style="white-space: nowrap;overflow: hidden;text-overflow: ellipsis;max-width: 260px;"><a
                                href="/server/<?php echo $b['ip'];?>:<?php echo $b['port'];?>/info"><?php echo $b['hostname'];?></a></td>
                    <td width="20%"><?php echo $b['ip'];?>
                        :<?php echo $b['port'];?></td>
                    <td width="12%">
                        <div class="uk-progress uk-progress-striped">
                            <div class="uk-progress-bar"
                                 style="width: <?php echo $show_playersBoost;?>;"> <?php echo $show_playersBoost;?></div>
                        </div>
                    </td>
                    <td width="18%"><?php echo $b['map'];?></td>
                    <td width="15%"><?php echo $b['boost'];?></td>
                </tr>
                <?php
$i++;
endforeach;
if($countBoostServers<1):
?>
                <tr>
                    <td colspan="6" align="center">Список серверов пуст</td>
                </tr>
                <?php endif;?>
                </tbody>
            </table>
            <?php endif;?>


            <?php if($settings['global_settings']['vip_on']==1):?>
            <h5>VIP СТАТУС</h5>

            <table class="table table-dark">
                <thead>
                <tr>
                    <th>#</th>
                    <th>Название сервера</th>
                    <th>Адрес</th>
                    <th>Заполненость</th>
                    <th>Карта</th>
                    <th>Оплачено до</th>
                </tr>
                </thead>
                <tbody>

                <?php $i = 1;
foreach($vipServers as $v):
$system = new System();
$show_playersVip = $system->showbar( $v['players'], $v['max_players'] );
                ?>
                <tr>
                    <td width="3%"><?php echo $i;?></a></td>
                    <td width="32%"
                        style="white-space: nowrap;overflow: hidden;text-overflow: ellipsis;max-width: 260px;"><a
                                href="/server/<?php echo $v['ip'];?>:<?php echo $v['port'];?>/info"><?php echo $v['hostname'];?></a></td>
                    <td width="20%">
                        <?php echo $v['ip'];?>
                        :<?php echo $v['port'];?></td>
                    <td width="12%">
                        <div class="uk-progress uk-progress-striped">
                            <div class="uk-progress-bar"
                                 style="width: <?php echo $show_playersVip;?>;"> <?php echo $show_playersVip;?></div>
                        </div>
                    </td>
                    <td width="18%"><?php echo $v['map'];?></td>
                    <td width="15%"><?php echo date("d.m.Y [H:i]", $v['vip_expired_date']);?></td>
                </tr>


                <?php
$i++;
endforeach;
if($countVipServers<1):
?>
                <tr>
                    <td colspan="6" align="center">Список серверов пуст</td>
                </tr>
                <?php endif;?>


                </tbody>
            </table>
            <?php endif;?>


            <?php if($settings['global_settings']['color_on']==1):?>
            <h5>Выделение цветом</h5>
            <table class="table table-dark">
                <thead>
                <tr>
                    <th>#</th>
                    <th>Название сервера</th>
                    <th>Адрес</th>
                    <th>Заполненость</th>
                    <th>Карта</th>
                    <th>Оплачено до</th>
                </tr>
                </thead>
                <tbody>
                <?php $i = 1;
foreach($colorServers as $c):
$system = new System();
$show_playersColor = $system->showbar( $c['players'], $c['max_players'] );
                ?>
                <tr>
                    <td width="3%"><?php echo $i;?></a></td>
                    <td width="32%"
                        style="white-space: nowrap;overflow: hidden;text-overflow: ellipsis;max-width: 260px;"><a
                                href="/server/<?php echo $c['ip'];?>:<?php echo $c['port'];?>/info><?php echo $c['hostname'];?></a></td>
                    <td width="20%">
                        <?php echo $c['ip'];?>
                        :<?php echo $c['port'];?></td>
                    <td width="12%">
                        <div class="uk-progress uk-progress-striped">
                            <div class="uk-progress-bar"
                                 style="width: <?php echo $show_playersColor;?>;"> <?php echo $show_playersColor;?></div>
                        </div>
                    </td>
                    <td width="18%"><?php echo $c['map'];?></td>
                    <td width="15%"><?php echo date("d.m.Y [H:i]", $c['color_expired_date']);?></td>
                </tr>
                <?php
$i++;
endforeach;
if($countColorServers<1):
?>
                <tr>
                    <td colspan="6" align="center">Список серверов пуст</td>
                </tr>
                <?php endif;?>
                </tbody>
            </table>
            <?php endif;?>


            <?php if($settings['global_settings']['gamemenu_on']==1):?>
            <h5>GameMenu</h5>

            <table class="table table-dark">
                <thead>
                <tr>
                    <th>#</th>
                    <th>Название сервера</th>
                    <th>Адрес</th>
                    <th>Заполненость</th>
                    <th>Карта</th>
                    <th>Оплачено до</th>
                </tr>
                </thead>
                <tbody>

                <?php $i = 1;
foreach($gamemenuServers as $g):
$system = new System();
$show_playersGamemenu = $system->showbar( $g['players'], $g['max_players'] );
                ?>
                <tr>
                    <td width="3%"><?php echo $i;?></a></td>
                    <td width="32%"
                        style="white-space: nowrap;overflow: hidden;text-overflow: ellipsis;max-width: 260px;"><a
                                href="/server/<?php echo $g['ip'];?>:<?php echo $g['port'];?>/info"><?php echo $g['hostname'];?></a></td>
                    <td width="20%"><?php echo $g['ip'];?>
                        :<?php echo $g['port'];?></td>
                    <td width="12%">
                        <div class="uk-progress uk-progress-striped">
                            <div class="uk-progress-bar"
                                 style="width: <?php echo $show_playersGamemenu;?>;"> <?php echo $show_playersGamemenu;?></div>
                        </div>
                    </td>
                    <td width="18%"><?php echo $g['map'];?></td>
                    <td width="15%"><?php echo date("d.m.Y [H:i]", $g['gamemenu_expired_date']);?></td>
                </tr>


                <?php
                    $i++;
                    endforeach;
                    if($countGamemenuServers<1):
                    ?>
                <tr>
                    <td colspan="6" align="center">Список серверов пуст</td>
                </tr>
                <?php endif;?>


                </tbody>
            </table>
            <?php endif;?>


        </div>

    </div>

</section>