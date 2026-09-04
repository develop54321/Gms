<section class="page">
    <div class="container">
        <h1 class="content-title">
            Заказ платной услуги
        </h1>
        <hr/>


        <?php if ($type == 'search'): ?>

            <?php if (!empty($servers)): ?>
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
                    <th scope="col"></th>
                </tr>
                </thead>
                <tbody>
                <?php foreach ($servers as $row): ?>
                    <tr>
                        <td><?php echo $row['id']; ?></td>
                        <td>
                            <span class="game-icon"><?php widgets\server\game\GameIcon::run($row['game']);?></span>
                        </td>
                        <td>
                            <a class="hostname" href="/server/<?php echo $row['ip']; ?>:<?php echo $row['port']; ?>/info"><?php echo \widgets\server\hostname\Hostname::run($row['hostname']); ?></a>
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

                        <td style="text-align: right;">
                            <a href="/pay/<?php echo $row['id']; ?>/select" class="btn btn-primary btn-sm">Выбрать
                                сервер</a>
                        </td>
                    </tr>
                <?php endforeach; ?>

                </tbody>
            </table>
            </div></div>
            <?php else: ?>
                <div class="empty-hint"><i class="fa fa-search"></i>По вашему запросу ничего не найдено!</div>
            <?php endif; ?>


        <?php elseif ($type == 'searchForm'): ?>

            <?php if (!empty($myServers)): ?>
                <h2 class="section-title mb-3" style="font-size:15px;"><i class="fa fa-server"></i> Ваши сервера</h2>

                <div class="mypay-grid">
                    <?php foreach ($myServers as $row): ?>
                        <a href="/pay/<?php echo $row['id'];?>/select" class="mypay-card">
                            <span class="game-icon"><?php widgets\server\game\GameIcon::run($row['game']);?></span>
                            <span class="mypay-card-body">
                                <span class="mypay-card-title"><?php echo \widgets\server\hostname\Hostname::run($row['hostname']);?></span>
                                <span class="mypay-card-addr"><?php echo $row['host'] ?? $row['ip'];?>:<?php echo $row['port'];?></span>
                            </span>
                            <span class="mypay-card-meta">
                                <span><?php echo (int)$row['players'];?>/<?php echo (int)$row['max_players'];?></span>
                                <span class="sri-dot <?php echo $row['status'] == 1 ? 'online' : 'offline';?>"></span>
                            </span>
                        </a>
                    <?php endforeach; ?>
                </div>

                <div class="mypay-divider"><span>или найдите другой сервер</span></div>
            <?php endif; ?>

            <div class="alert alert-warning" role="alert">
                <p class="mb-0">
                    Если вы хотите заказать платную услугу, воспользуйтесь поиском сервера или выберите его из списка. <br/>Также можно оформить услугу прямо на странице нужного сервера.
                </p>
            </div>

            <form method="post" class="d-flex gap-2 flex-wrap">
                <input type="text" class="form-control" name="query"
                       style="max-width: 320px;" placeholder="Адрес сервера">
                <button type="submit" class="btn btn-primary">Найти</button>
            </form>
        <?php endif; ?>

    </div>


</section>