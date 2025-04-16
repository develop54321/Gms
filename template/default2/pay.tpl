<section class="page">
    <div class="container">
        <h1 class="content-title">
            Заказ платной услуги
        </h1>
        <hr/>


        <?php if ($type == 'search'): ?>

            <table class="table table-dark">
                <thead class="thead-dark">
                <tr>
                    <th scope="col">#</th>
                    <th scope="col">Игра</th>
                    <th scope="col">Название</th>
                    <th scope="col">Адрес</th>
                    <th scope="col">Карта</th>
                    <th scope="col">Игроки</th>
                    <th scope="col" style="text-align: center;">Рейтинг</th>
                    <th scope="col"></th>
                </tr>
                </thead>
                <tbody>
                <?php foreach ($servers as $row): ?>
                    <tr>
                        <th><?php echo $row['id']; ?></th>
                        <th>
                            <?php \widgets\server\game\GameIcon::run($row['game']);?>
                        </th>
                        <td>
                            <a href="/server/<?php echo $row['ip']; ?>:<?php echo $row['port']; ?>/info"><?php echo \widgets\server\hostname\Hostname::run($row['hostname']); ?></a>
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

                        <td style="text-align: right;">
                            <a href="/pay/<?php echo $row['id']; ?>/select" class="btn btn-primary btn-sm">Выбрать
                                сервер</a>
                        </td>
                    </tr>
                <?php endforeach; ?>

                </tbody>
            </table>
            <?php if (empty($servers)): ?>
                <h3 style="text-align: center;">По вашему запросу ничего не найдено!</h3>
            <?php endif; ?>


        <?php elseif ($type == 'searchForm'): ?>

            <form method="post">
                <div class="alert alert-warning" role="alert">
                    <p>
                        Для того чтобы заказать какую-либо платную услугу, надо сначала найти сервер в списке или через поиск.<br/>
                        Либо вы можете заказать услуги через страницу сервера.
                    </p>
                </div>

                <input type="text" class="form-control" name="query"
                       style="width: 240px;float: left;margin-right: 3px;" placeholder="Адрес сервера">
                <button type="submit" class="btn btn-primary">Найти</button>


            </form>
        <?php endif; ?>

    </div>


</section>