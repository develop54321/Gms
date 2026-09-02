<section class="page">
    <div class="container">
        <h1 class="content-title">
            Раскрутка сервера
        </h1>
        <hr/>

        <div class="section-boost">

            <div class="alert alert-warning">
                <p>
                    Услуга "Раскрутка сервера", работает следующим образом: существует список, содержащий ровно n
                    серверов, которые добавляются только в мастер-сервер. <br/>
                    Каждый новый добавленный сервер вытесняет последний сервер в списке. Таким образом, первый сервер
                    перемещается на второе место, второй — на третье и так далее, а сервер, который выходит за пределы
                    списка, удаляется из списка.
                </p>
            </div>

            <div class="table-card"><div class="table-responsive">
            <table class="table servers-table">
                <thead>
                <tr>
                    <th scope="col">#</th>
                    <th scope="col">Игра</th>
                    <th scope="col">Название</th>
                    <th scope="col">Адрес</th>
                    <th scope="col">Карта</th>
                    <th scope="col">Игроки</th>
                    <th scope="col" style="text-align: center;">Кругов</th>
                </tr>
                </thead>
                <tbody>
                <?php foreach ($boostServers as $row): ?>
                    <tr>
                        <td><?php echo $row['id']; ?></td>
                        <td>
                            <span class="game-icon"><?php echo \widgets\server\game\GameIcon::run($row['game']); ?></span>
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
           <span class="address">
      <?php echo $row['boost']; ?>
           </span>
                        </td>
                    </tr>
                <?php endforeach; ?>

                </tbody>
            </table>
            </div></div>

        </div>
    </div>
</section>