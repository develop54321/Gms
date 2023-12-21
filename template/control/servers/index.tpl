<div class="row">
<div class="col-sm-12">
<h4 class="page-title">Серверы</h4>
<ol class="breadcrumb">
<li><a href="/control">Главная</a></li>
<li class="active">Серверы</li>
</ol>
</div>
</div>


<div class="col-sm-12">
<div class="card-box">
<h4 class="m-t-0 header-title"><b>Фильтр</b> <i class="fa fa-filter"></i></h4>
<p class="text-muted m-b-30 font-12">Всего найдено элэментов: <?php echo $filter['count'];?></p>

<form action="/control/servers/search" method="get">
<div class="row">

<div class="col-md-3">
<div class="form-group">
<label>Адрес сервера</label>
<input type="text" name="address" class="form-control input-sm" value="<?php echo $filter['address'];?>">
</div>
</div>

<div class="col-md-3">
<div class="form-group">
<label>Статус</label>
<select name="status" class="form-control input-sm">
<option value="">--Не выбрана--</option>
<option value="1" <?php if($filter['status'] == '1'):?>selected<?php endif;?>>Показывается</option>
<option value="0" <?php if($filter['status'] == '0'):?>selected<?php endif;?>>Ожидают проверку</option>
</select>
</div>
</div>

</div>


<button type="submit" class="btn btn-primary waves-effect waves-light btn-sm">
Найти
</button>








</form>
</div>


<div class="card-box">
<h4 class="m-t-0 header-title"><b>Серверы</b></h4>
<p class="text-muted m-b-30 font-12">серверы по умолчанию сортируется по рейтингу</p>





<table class="table table table-hover m-0">
  <thead>
    <tr>
      <th scope="col">#</th>
      <th scope="col">Игра</th>
      <th scope="col">Название</th>
      <th scope="col">Адрес</th>
      <th scope="col">Дата добавления</th>
      <th scope="col"></th>
    </tr>
  </thead>
  <tbody>
   <?php foreach($servers as $row):?>
   <?php 
   if(file_exists("public/img/flags/".strtolower($row['country']).".png")){
    $imgCountry = "/public/img/flags/".strtolower($row['country']).".png";
   }else{
    $imgCountry = "/public/img/flags/unknown.png";
   }
   
   ?>
    <tr id="server<?php echo $row['id'];?>">
      <td><?php echo $row['id'];?></td>
      <td>
        <?php widgets\server\game\Status::run($row['game']);?>
      </td>
      <td><a href="/server/info?id=<?php echo $row['id'];?>"><?php echo $row['hostname'];?></a></td>
      <td><img src="<?php echo $imgCountry;?>" alt="<?php echo $row['hostname'];?>"/> <?php echo $row['ip'];?>:<?php echo $row['port'];?></td>
      <td>
      <?php echo date("d:m:Y [H:i]", $row['date_add']);?>
      </td>
    
      
    
      
      <td>
      <a href="/control/servers/edit?id=<?=$row['id'];?>" class="text-muted" title="Изменить сервер"><i class="fa fa-pencil"></i></a>
<a href="#" onclick="remove(<?=$row['id'];?>); return false;" class="text-muted" title="Удалить сервер"><i class="fa fa-trash"></i></a>

      </td>
    </tr>
    <?php endforeach;?>
    
  </tbody>
</table>

<?php if(!isset($action)):?>
<div class="pagination">
<?php foreach($ViewPagination as $p):?>
<?php echo $p[0];?>
<?php endforeach;?>
</div>
<?php endif;?>



</div>
</div>

<script>
function remove(id){
    if(confirm("Вы действительно хотите удалить?")){
     $.ajax({
        url: "/control/servers/remove",
        data: {'id':id},
        success: function(){
        $('#server'+id+'').hide(300);
        }
     });  
    }
}
</script>