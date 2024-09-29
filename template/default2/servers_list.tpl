<?php \widgets\common\games\menu\Menu::run();?>

<div class="servers-list">
    <div class="container">

        <div class="title">
            <h3>
                <i class="fa fa-star-o"></i>   Список серверов
            </h3>
        </div>

        <div class="table-responsive">
            <table class="table table-dark">
                <thead>
                <tr>
                    <th scope="col">Игра</th>
                    <th scope="col">Название</th>
                    <th scope="col">Адрес</th>
                    <th scope="col">Карта</th>
                    <th scope="col">Игроки</th>
                    <th scope="col" style="text-align: center;">Рейтинг</th>
                </tr>
                </thead>
                <tbody>
                <?php foreach($servers as $row):?>
                <tr
                <?php if($row['color_enabled'] != null):?>style="background: <?php echo $row['color_enabled'];?>
                "<?php endif;?>>
                <td>
                    <?php widgets\server\game\Status::run($row['game']);?>
                    <a href="?game=<?=$row['game'];?>"></a>
                </td>
                <td><a class="hostname" href="/server/<?php echo $row['ip'];?>:<?php echo $row['port'];?>/info"><?php echo $row['hostname'];?></a></td>
                <td>
                    <span class="address">
                        <?php echo $row['ip'];?>:<?php echo $row['port'];?>
                    </span>

                </td>
                <td><?php echo $row['map'];?></td>
                <td>
                    <span class="players">
                        <?php echo $row['players'];?>/<?php echo $row['max_players'];?>
                    </span>
                </td>
                <td style="text-align: center;">
                    <?php if($row['vip_enabled'] != '0'):?>
                    <b>VIP</b>
                    <?php else:?>
                    <a href="#" onclick="ShowModal('<?=$row['id'];?>', 'vote', 'minus');return false;"><i class="fa fa-thumbs-down"></i></a>
                    <span class="vote">
                        <label id="vote<?php echo $row['id'];?>" class="rating-bg"><?php echo $row['rating'];?></label>
                    </span>
                    <a href="#" onclick="ShowModal('<?=$row['id'];?>', 'vote', 'plus');return false;"><i class="fa fa-thumbs-up"></i></a>
                    <?php endif;?>

                </td>
                </tr>
                <?php endforeach;?>

                </tbody>
            </table>

            <div class="pagination">
                <nav aria-label="Page navigation example">
                    <ul class="pagination">
                <?php foreach($ViewPagination as $p):?>
                <?php echo $p[0];?>
                <?php endforeach;?>
                    </ul>
                </nav>
            </div>

        </div>
    </div>
</div>