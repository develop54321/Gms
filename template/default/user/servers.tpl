<div class="content">
<nav aria-label="breadcrumb">
  <ol class="breadcrumb">
    <li class="breadcrumb-item"><a href="/">Главная</a></li>
    <li class="breadcrumb-item active" aria-current="page">Мои сервера</li>
  </ol>
</nav>

<div class="alert alert-info">
<b>Как добавить свой сервер?</b>
<p>При добавления сервера через сайт, в авторизованном виде, Вы автоматически становитесь владельцем данного сервера.
</p>
</div>

<?php $url = "servers"; include("UserMenu.tpl");?>




<div class="my-servers-list">
<?php foreach($servers as $row):?>
<?php
$path = 'public/img/maps/'.$row['map'].'.jpg';
if(file_exists($path)){
$img_map = '/'.$path;
}else{
$img_map = '/public/img/no_map.png';
}
?>
<div class="server-info" style="min-height: 0px;">
<a href="#" onclick="remove(<?=$row['id'];?>); return false;" class="btn-remove-server" title="Удалить сервер"><i class="fa fa-trash"></i></a>
<div class="img">
<img src="<?=$img_map;?>" title="<?=$row['map'];?>"/> 
</div>

<div class="info">
<ul>
<li>id сервера: #<?php echo $row['id'];?></li>
<li>Название: <a href="/server/<?php echo $row['ip'];?>:<?php echo $row['port'];?>/info"><?php echo $row['hostname'];?></a></li>
<li>Адрес: <?php echo $row['ip'];?>:<?php echo $row['port'];?></li>
<li>Игроки: <?php echo $row['players'];?>/<?php echo $row['max_players'];?></li>
<li>Карта: <?php echo $row['map'];?></li>
<li>Рейтинг: <label id="vote<?php echo $row['id'];?>" class="rating-bg"><?php echo $row['rating'];?></label> </li>
</ul>

</div>

<div class="info-2">
<ul>
<li>
Состояние:
<?php if($row['moderation'] == '1'):?>
<span class="badge badge-primary">Показывается</span>
<?php else:?>
<span class="badge badge-warning">Ожидает проверки администратором</span>
<?php endif;?>
</li>
<li>Статус:
<?php if($row['ban'] == '1'):?>
<span class="badge badge-danger">Забанен</span>
<?php else:?>
<?php if($row['status'] == '1'):?>
<span class="badge badge-success">Работает</span>
<?php elseif($row['status'] == '0'):?>
<span class="badge badge-warning">Недоступен</span>
<?php endif;?>
<?php endif;?>
</li>
<li>Владелец: <?=$row['email'];?></li>
<li><a href="#" onclick="ShowModal('<?=$row['id'];?>', 'serverServices', 'null');return false;">Показать услуги</a></li>
</ul>

</div>



<div class="clearfix"></div>
</div>
<?php endforeach;?>
</div>

<div class="pagination">
<?php foreach($ViewPagination as $p):?>
<?php echo $p[0];?>
<?php endforeach;?>
</div>



</div>
<script>
function remove(id){
    if(confirm("Вы действительно хотите удалить данный сервер?")){
    $.ajax({
     url: "/user/removeserver?id="+id,
     dataType: "json",
     success: function(data){
                    switch(data.status){
                        case "error":
                        ShowModal(data.error, 'answer', 'error');
                        break;
                        
                        case "success":
                        ShowModal(data.success, 'answer', 'success');
                        break;
                        

                    }
                },
      
    });
}
}
</script>
