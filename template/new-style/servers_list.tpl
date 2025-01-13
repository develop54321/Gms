<section class="list-servers">
    <div class="container">
        <div class="mb-2">
            <a href="/server/add" class="btn btn-outline-success"><i class="fa fa-star-o"></i> Добавить сервер бесплатно</a>
        </div>

        <div class="name-block text-center">
            <i class="fa fa-star-o"></i> Список серверов
        </div>

        <div class="serversList">
            <table class="table table-striped table-hover">
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
                    <?php widgets\server\game\GameIcon::run($row['game']);?>
                    <a href="?game=<?=$row['game'];?>"></a>
                </td>
                <td><a class="hostname" href="/server/<?php echo $row['ip'];?>:<?php echo $row['port'];?>/info"><?php echo $row['hostname'];?></a></td>
                <td><?php echo $row['ip'];?>:<?php echo $row['port'];?></td>
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
                <nav aria-label="Pagination">
                    <ul class="pagination justify-content-center">
                        <?= implode("\n", $pagination_html) ?>
                    </ul>
                </nav>
            </div>

        </div>
    </div>
</section>