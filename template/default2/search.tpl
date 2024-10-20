<section class="page">
    <div class="container">
        <h1 class="content-title">
            Поиск
        </h1>
        <hr/>

            <?php if ($servers):?>
            <table class="table table-dark">
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
                    <tr>
                        <td><?php echo $row['id']; ?></td>
                        <td>
                            <?php echo \widgets\server\game\GameIcon::run($row['game']);?>
                        </td>
                        <td>
                            <a href="/server/<?php echo $row['ip']; ?>:<?php echo $row['port']; ?>/info"><?php echo $row['hostname']; ?></a>
                        </td>
                        <td>
                              <span class="address">
                            <?php echo $row['ip']; ?>:<?php echo $row['port']; ?>
                              </span>
                        </td>
                        <td><?php echo $row['map']; ?></td>
                        <td>
                              <span class="players">
                            <?php echo $row['players']; ?>/<?php echo $row['max_players']; ?>
                              </span>

                        </td>
                        <td style="text-align: center;">
                            <?php if ($row['vip_enabled'] != '0'): ?>
                                VIP
                            <?php else: ?>

                                <a href="#" onclick="ShowModal('<?=$row['id'];?>', 'vote', 'minus');return false;"><i class="fa fa-thumbs-down"></i></a>

                                <label id="vote<?php echo $row['id']; ?>"
                                       class="rating-bg"><?php echo $row['rating']; ?></label>

                                <a href="#" onclick="ShowModal('<?=$row['id'];?>', 'vote', 'plus');return false;"><i class="fa fa-thumbs-up"></i></a>
                            <?php endif; ?>

                        </td>
                    </tr>
                <?php endforeach; ?>

                </tbody>
            </table>
            <?php endif;?>

            <?php if (empty($servers)): ?>
                <h3>По вашему запросу ничего не найдено!</h3>
            <?php endif; ?>


        </div>
</section>