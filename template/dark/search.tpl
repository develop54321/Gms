<section class="page">
    <div class="container">
        <h1 class="content-title">
            Поиск
        </h1>
        <hr/>

            <?php if ($servers):?>
            <div class="table-card"><div class="table-responsive">
            <table class="table servers-table mb-0">
                <thead>
                <tr>
                    <th scope="col">#</th>
                    <th scope="col">Игра</th>
                    <th scope="col">Название</th>
                    <th scope="col">Адрес</th>
                    <th scope="col">Карта</th>
                    <th scope="col">Игроки</th>
                    <th scope="col" style="text-align: center;">Рейтинг</th>
                </tr>
                </thead>
                <tbody>
                <?php foreach ($servers as $row): ?>
                <tr <?php if($row['color_enabled'] != null):?>class="row-color" style="box-shadow: inset 3px 0 0 <?php echo $row['color_enabled'];?>;"<?php endif;?>>
                        <td><?php echo $row['id']; ?></td>
                        <td>
                            <span class="game-icon"><?php echo \widgets\server\game\GameIcon::run($row['game']);?></span>
                        </td>
                        <td>
                            <a class="hostname" href="/server/<?php echo $row['ip']; ?>:<?php echo $row['port']; ?>/info"><?php echo \widgets\server\hostname\Hostname::run($row['hostname']); ?></a>
                        </td>
                        <td>
                              <span class="address">
                            <?php echo $row['host'] ?? $row['ip']; ?>:<?php echo $row['port']; ?>
                              </span>
                        </td>
                        <td><?php echo $row['map']; ?></td>
                        <td>
                              <span class="players">
                            <?php echo $row['players']; ?>/<?php echo $row['max_players']; ?>
                              </span>

                        </td>
                        <td style="text-align: center;">
                            <?php if ($row['vip_enabled'] !== null): ?>
                            <span class="badge badge-vip"><i class="fa fa-star"></i> VIP</span>
                            <?php else: ?>
                                <div class="rating">
                                <a href="#" onclick="ShowModal('<?=$row['id'];?>', 'vote', 'minus');return false;"><i class="fa fa-thumbs-down"></i></a>

                                <label id="vote<?php echo $row['id']; ?>"
                                       class="rating-bg"><?php echo $row['rating']; ?></label>

                                <a href="#" onclick="ShowModal('<?=$row['id'];?>', 'vote', 'plus');return false;"><i class="fa fa-thumbs-up"></i></a>
                                </div>
                            <?php endif; ?>

                        </td>
                    </tr>
                <?php endforeach; ?>

                </tbody>
            </table>
            </div></div>
            <?php endif;?>

            <?php if (empty($servers)): ?>
                <div class="empty-hint"><i class="fa fa-search"></i>По вашему запросу ничего не найдено!</div>
            <?php endif; ?>


        </div>
</section>