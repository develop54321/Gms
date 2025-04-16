<section class="page banlist">
    <div class="container">
        <h1 class="content-title">
            Раскрутка сервера
        </h1>
        <hr/>

<div class="section-boost">

<div class="alert alert-warning">
<p>
    Услуга "Раскрутка сервера", работает следующим образом: существует список, содержащий ровно n серверов, которые добавляются только в мастер-сервер. <br/>
    Каждый новый добавленный сервер вытесняет последний сервер в списке. Таким образом, первый сервер перемещается на второе место, второй — на третье и так далее, а сервер, который выходит за пределы списка, удаляется из списка.
</p>
</div>

<table class="table table-dark">
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
   <?php foreach($boostServers as $row):?>
    <tr>
      <td><?php echo $row['id'];?></td>
      <td>
          <?php echo \widgets\server\game\GameIcon::run($row['game']);?>
      </td>
      <td><a href="/server/<?php echo $row['ip'];?>:<?php echo $row['port'];?>/info"><?php echo \widgets\server\hostname\Hostname::run($row['hostname']);?></a></td>
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
      <?php echo $row['boost'];?>
      </td>
    </tr>
    <?php endforeach;?>
    
  </tbody>
</table>


</div>
    </div>
</section>