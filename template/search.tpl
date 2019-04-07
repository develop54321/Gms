<div class="content">
<nav aria-label="breadcrumb">
  <ol class="breadcrumb">
    <li class="breadcrumb-item"><a href="/">Главная</a></li>
    <li class="breadcrumb-item active" aria-current="page">Поиск сервера</li>
  </ol>
</nav>
<table class="table">
  <thead class="thead-dark">
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
   <?php foreach($servers as $row):?>
    <tr>
      <td><?php echo $row['id'];?></td>
      <td>
      <?php if($row['game'] == 'cs'):?>
      <img src="/public/img/gameicons/cs.png" style="width: 16px;"/>
      <?php elseif($row['game'] == 'csgo'):?>
      <img src="/public/img/gameicons/csgo.png" style="width: 16px;"/>
      <?php elseif($row['game'] == 'css'):?>
      <img src="/public/img/gameicons/css.png" style="width: 16px;"/>
      <?php endif;?>
      </td>
      <td><a href="/server/info?id=<?php echo $row['id'];?>"><?php echo $row['hostname'];?></a></td>
      <td><?php echo $row['ip'];?>:<?php echo $row['port'];?></td>
      <td><?php echo $row['map'];?></td>
            <td><?php echo $row['players'];?>/<?php echo $row['max_players'];?></td>
      <td style="text-align: center;">
      <?php if($row['vip_enabled'] != '0'):?>
      VIP
      <?php else:?>
       <a href="#" onclick="votePlus(<?php echo $row['id'];?>);return false;"><i class="fa fa-minus"></i></a> 
       <label id="vote<?php echo $row['id'];?>" class="badge badge-info"><?php echo $row['rating'];?></label> 
      <a href="#" onclick="votePlus(<?php echo $row['id'];?>);return false;"><i class="fa fa-plus"></i></a>
      <?php endif;?>
      
      </td>
    </tr>
    <?php endforeach;?>
    
  </tbody>
</table>

<?php if(empty($servers)):?>
<h3 style="text-align: center;">По вашему запросу ничего не найдено!</h3>
<?php endif;?>


</div>