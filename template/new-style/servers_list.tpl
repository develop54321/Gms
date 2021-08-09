<section class="list-servers">
    <div class="container">


        <div class="name-block">
            <i class="fa fa-star-o"></i> Список серверов
        </div>


        <div class="serversList">
            <table class="table">
                <thead>
                <tr>
                    <th scope="col">Игра</th>
                    <th scope="col">Название</th>
                    <th scope="col">Адрес</th>
                    <th scope="col"></th>
                    <th scope="col">Карта</th>
                    <th scope="col">Игроки</th>
                    <th scope="col" style="text-align: center;">Рейтинг</th>
                </tr>
                </thead>
                <tbody>
                <?php foreach($servers as $row):?>
                <?php
   if(file_exists("public/img/flags/".strtolower($row['country']).".png")){
    $imgCountry = "public/img/flags/".strtolower($row['country']).".png";
   }else{
    $imgCountry = "public/img/flags/unknown.png";
   }
   
   ?>
                <tr
                <?php if($row['color_enabled'] != null):?>style="background: <?php echo $row['color_enabled'];?>
                "<?php endif;?>>
                <td>
                    <?php widgets\servers\status\Status::run($row['game']);?>
                    <a href="?game=<?=$row['game'];?>">


                    </a>
                </td>
                <td><a class="hostname"
                       href="/server/info?id=<?php echo $row['id'];?>"><?php echo $row['hostname'];?></a></td>
                <td><img src="<?php echo $imgCountry;?>" alt="<?php echo $row['hostname'];?>"/> <?php echo $row['ip'];?>
                    :<?php echo $row['port'];?></td>
                <td><a href="steam://connect/<?php echo $row['ip'];?>:<?php echo $row['port'];?>">
                        <i class="fa fa-gamepad text-dark" title="<?=$lang['connect_to_server'];?>"></i></a></td>
                <td><?php echo $row['map'];?></td>
                <td><?php echo $row['players'];?>/<?php echo $row['max_players'];?></td>
                <td style="text-align: center;">
                    <?php if($row['vip_enabled'] != '0'):?>
                    <b>VIP</b>
                    <?php else:?>
                    <a href="#" onclick="ShowModal('<?=$row['id'];?>', 'vote', 'minus');return false;"><i
                                class="fa fa-minus"></i></a>
                    <label id="vote<?php echo $row['id'];?>" class="rating-bg"><?php echo $row['rating'];?></label>
                    <a href="#" onclick="ShowModal('<?=$row['id'];?>', 'vote', 'plus');return false;"><i
                                class="fa fa-plus"></i></a>
                    <?php endif;?>

                </td>
                </tr>
                <?php endforeach;?>

                </tbody>
            </table>

            <div class="pagination">
                <?php foreach($ViewPagination as $p):?>
                <?php echo $p[0];?>
                <?php endforeach;?>
            </div>

        </div>
    </div>
</section>