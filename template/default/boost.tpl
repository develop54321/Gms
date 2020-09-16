<div class="content">
<nav aria-label="breadcrumb">
  <ol class="breadcrumb">
    <li class="breadcrumb-item"><a href="/">Главная</a></li>
    <li class="breadcrumb-item active" aria-current="page">Раскрутка сервера</li>
  </ol>
</nav>

<div class="alert alert-info">
<b>Turbo Boost</b>
<p>Смысл услуги Turbo boost cs 1.6 таков: список содержит в себе ровно 100 серверов и cервера добавляются только в мастер сервер, каждый добавленный новый сервер выталкивает из списка сервер, который находится на 100 месте. <br/>
То есть первый становится вторым и т.д., 100 сервер пропадает.

</p>
</div>

<table class="table">
  <thead class="thead-dark">
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
      <?php if($row['game'] == 'cs'):?>
      <img src="/public/img/gameicons/cs.png" style="width: 16px;"/>
      <?php elseif($row['game'] == 'csgo'):?>
      <img src="/public/img/gameicons/csgo.png" style="width: 16px;"/>
      <?php elseif($row['game'] == 'css'):?>
      <img src="/public/img/gameicons/css.png" style="width: 16px;"/>
      <?php elseif($row['game'] == 'tf2'):?>
      <img src="/public/img/gameicons/tf2.png" style="width: 16px;"/>
       <?php elseif($row['game'] == 'ld2'):?>
      <img src="/public/img/gameicons/ld2.png" style="width: 16px;"/>
      <?php endif;?>
      </td>
      <td><a href="/server/info?id=<?php echo $row['id'];?>"><?php echo $row['hostname'];?></a></td>
      <td><?php echo $row['ip'];?>:<?php echo $row['port'];?></td>
      <td><?php echo $row['map'];?></td>
            <td><?php echo $row['players'];?>/<?php echo $row['max_players'];?></td>
      <td style="text-align: center;">
      <?php echo $row['boost'];?>
      </td>
    </tr>
    <?php endforeach;?>
    
  </tbody>
</table>


</div>