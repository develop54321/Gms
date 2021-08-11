<section class="content mt-5">
    <div class="container">


        <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="/">Главная</a></li>
                <li class="breadcrumb-item active" aria-current="page">Листинг серверов</li>
            </ol>
        </nav>

        <span style="float: right;">Текущее время:<br><?php echo date("d.m.Y [H:i]");?></span>

        <table class="table">
            <thead>
            <tr>
                <th>Услуга</th>
                <th>Описание</th>
                <th style="text-align: center;">Свободные места</th>
                <th style="text-align: center;">Ближайшее место</th>
            </tr>
            </thead>
            <tbody>
            <?php
if($settings['global_settings']['top_on']==0 and $settings['global_settings']['boost_on']==0 and $settings['global_settings']['vip_on']==0 and $settings['global_settings']['color_on']==0):
?>
            <tr>
                <td colspan="6" align="center">Платные услуги отключены</td>
            </tr>
            <?php endif;?>

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
            <h5 style="padding-top: 25px;">ПРЕМИУМ МЕСТО</h5>
            <table class="table">
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
                                href="/server/info?id=<?php echo $t['id'];?>"><?php echo $t['hostname'];?></a></td>
                    <td width="20%"><img src="<?php echo $t['imgCountry'];?>" width="17"
                                         alt="<?php echo $t['country'];?>"
                                         title="<?php echo $t['country'];?>">&ensp;<?php echo $t['ip'];?>
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
            <h5 style="padding-top: 25px;">BOOST</h5>

            <table class="table">
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
if(file_exists("public/img/flags/".strtolower($b['country']).".png")){
	$imgCountryBoost = "public/img/flags/".strtolower($b['country']).".png";
}else{
	$imgCountryBoost = "public/img/flags/unknown.png";
}
$system = new System();
$show_playersBoost = $system->showbar( $b['players'], $b['max_players'] );
                ?>
                <tr>
                    <td width="3%"><?php echo $i;?></a></td>
                    <td width="32%"
                        style="white-space: nowrap;overflow: hidden;text-overflow: ellipsis;max-width: 260px;"><a
                                href="/server/info?id=<?php echo $b['id'];?>"><?php echo $b['hostname'];?></a></td>
                    <td width="20%"><img src="<?php echo $imgCountryBoost;?>" width="17"
                                         alt="<?php echo $b['country'];?>"
                                         title="<?php echo $b['country'];?>">&ensp;<?php echo $b['ip'];?>
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
            <h5 style="padding-top: 25px;">VIP СТАТУС</h5>

            <table class="table">
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
if(file_exists("public/img/flags/".strtolower($v['country']).".png")){
	$imgCountryVip = "public/img/flags/".strtolower($v['country']).".png";
}else{
	$imgCountryVip = "public/img/flags/unknown.png";
}
$system = new System();
$show_playersVip = $system->showbar( $v['players'], $v['max_players'] );
                ?>
                <tr>
                    <td width="3%"><?php echo $i;?></a></td>
                    <td width="32%"
                        style="white-space: nowrap;overflow: hidden;text-overflow: ellipsis;max-width: 260px;"><a
                                href="/server/info?id=<?php echo $v['id'];?>"><?php echo $v['hostname'];?></a></td>
                    <td width="20%"><img src="<?php echo $imgCountryVip;?>" width="17" alt="<?php echo $v['country'];?>"
                                         title="<?php echo $v['country'];?>">&ensp;<?php echo $v['ip'];?>
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
            <h5 style="padding-top: 25px;">Выделение цветом</h5>
            <table class="table">
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
if(file_exists("public/img/flags/".strtolower($c['country']).".png")){
	$imgCountryColor = "public/img/flags/".strtolower($c['country']).".png";
}else{
	$imgCountryColor = "public/img/flags/unknown.png";
}
$system = new System();
$show_playersColor = $system->showbar( $c['players'], $c['max_players'] );
                ?>
                <tr>
                    <td width="3%"><?php echo $i;?></a></td>
                    <td width="32%"
                        style="white-space: nowrap;overflow: hidden;text-overflow: ellipsis;max-width: 260px;"><a
                                href="/server/info?id=<?php echo $c['id'];?>"><?php echo $c['hostname'];?></a></td>
                    <td width="20%"><img src="<?php echo $imgCountryColor;?>" width="17"
                                         alt="<?php echo $c['country'];?>"
                                         title="<?php echo $c['country'];?>">&ensp;<?php echo $c['ip'];?>
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
            <h5 style="padding-top: 25px;">GameMenu</h5>

            <table class="table">
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
if(file_exists("public/img/flags/".strtolower($g['country']).".png")){
	$imgCountryGamemenu = "public/img/flags/".strtolower($g['country']).".png";
}else{
	$imgCountryGamemenu = "public/img/flags/unknown.png";
}
$system = new System();
$show_playersGamemenu = $system->showbar( $g['players'], $g['max_players'] );
                ?>
                <tr>
                    <td width="3%"><?php echo $i;?></a></td>
                    <td width="32%"
                        style="white-space: nowrap;overflow: hidden;text-overflow: ellipsis;max-width: 260px;"><a
                                href="/server/info?id=<?php echo $g['id'];?>"><?php echo $g['hostname'];?></a></td>
                    <td width="20%"><img src="<?php echo $imgCountryGamemenu;?>" width="17"
                                         alt="<?php echo $g['country'];?>"
                                         title="<?php echo $g['country'];?>">&ensp;<?php echo $g['ip'];?>
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