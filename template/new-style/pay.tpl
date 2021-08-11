<section class="content mt-5">
  <div class="container">
    <nav aria-label="breadcrumb">
      <ol class="breadcrumb">
        <li class="breadcrumb-item"><a href="/">Главная</a></li>
        <li class="breadcrumb-item active" aria-current="page">Платные услуги</li>
      </ol>
    </nav>


<?php if($type == 'search'):?>

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
      <th scope="col"></th>
    </tr>
  </thead>
  <tbody>
   <?php foreach($servers as $row):?>
    <tr>
      <th><?php echo $row['id'];?></th>
      <th>
      <?php if($row['game'] == 'cs'):?>
      <img src="/public/img/gameicons/cs.png" style="width: 16px;"/>
      <?php elseif($row['game'] == 'csgo'):?>
      <img src="/public/img/gameicons/csgo.png" style="width: 16px;"/>
      <?php elseif($row['game'] == 'css'):?>
      <img src="/public/img/gameicons/css.png" style="width: 16px;"/>
      <?php endif;?>
      </th>
      <td><a href="/server/info/<?php echo $row['id'];?>"><?php echo $row['hostname'];?></a></td>
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
      
      <td style="text-align: right;">
      <a href="/pay/server?id=<?php echo $row['id'];?>" class="btn btn-primary btn-sm">Выбрать сервер</a>
      </td>
    </tr>
    <?php endforeach;?>
    
  </tbody>
</table>
<?php if(empty($servers)):?>
<h3 style="text-align: center;">По вашему запросу ничего не найдено!</h3>
<?php endif;?>


<?php elseif($type == 'searchForm'):?>


<form method="post">
  <div class="alert alert-dark" role="alert">
    Для того чтобы заказать какую-либо платную услугу, надо сначала найти сервер.
  </div>

<input type="text" class="form-control form-control-sm" name="query" style="width: 200px;float: left;margin-right: 3px;" placeholder="Адрес сервера">
<button type="submit" class="btn btn-primary btn-sm">Найти</button>
    

</form>

<?php elseif($type == 'selectServices'):?>
<?php if(empty($services)):?>
<h3 style="text-align: center;">Нету достные услуг для заказа</h3>
<?php else:?>
<h4>Выбранный вами сервер: <?php echo $serverInfo['hostname'];?></h4>
<?php endif;?>
<form method="POST" action="/pay/server?id=<?php echo $serverInfo['id'];?>&step=2">
<div class="form-row">
<div class="col-md-5">
<h4>Выберите услугу:</h4>
<select class="form-control form-control-sm" id="id_services" name="id_services" onclick="updateForm();">
<option>-------------</option>
<?php foreach($services as $s):?>
<?php if($s['type'] == 'razz'):?>
<?php if($serverInfo['ban'] == 0):?>
<option value="<?php echo $s['id'];?>" disabled=""><?php echo $s['name'];?></option>
<?php else:?>
<option value="<?php echo $s['id'];?>"><?php echo $s['name'];?></option>
<?php endif;?>
<?php else:?>
<?php if($serverInfo['ban'] == 0):?>
<?php if($s['type'] == 'befirst' and $settings['global_settings']['befirst_on'] == 1):?><option value="<?php echo $s['id'];?>"><?php echo $s['name'];?></option><?php endif;?>
<?php if($s['type'] == 'top' and $settings['global_settings']['top_on'] == 1):?><option value="<?php echo $s['id'];?>"><?php echo $s['name'];?></option><?php endif;?>
<?php if($s['type'] == 'boost' and $settings['global_settings']['boost_on'] == 1):?><option value="<?php echo $s['id'];?>"><?php echo $s['name'];?></option><?php endif;?>
<?php if($s['type'] == 'vip' and $settings['global_settings']['vip_on'] == 1):?><option value="<?php echo $s['id'];?>"><?php echo $s['name'];?></option><?php endif;?>
<?php if($s['type'] == 'color' and $settings['global_settings']['color_on'] == 1):?><option value="<?php echo $s['id'];?>"><?php echo $s['name'];?></option><?php endif;?>
<?php if($s['type'] == 'gamemenu' and $settings['global_settings']['gamemenu_on'] == 1):?><option value="<?php echo $s['id'];?>"><?php echo $s['name'];?></option><?php endif;?>
<?php if($s['type'] == 'votes' and $settings['global_settings']['votes_on'] == 1):?><option value="<?php echo $s['id'];?>"><?php echo $s['name'];?></option><?php endif;?>
<?php endif;?>
<?php endif;?>
<?php endforeach;?>
</select>
</div>
</div>


<div id="contentForm"></div>
</form>



<script>
function updateForm(){
    id_services = $("#id_services").val();
    $.ajax({
       url: "/pay/getform",
       data: {'id_services':id_services, 'id_server':<?php echo $serverInfo['id'];?>},
       success: function(data){
        $("#contentForm").html(data);
       }, 
    });
}
</script>
<?php endif;?>
  </div>
</section>