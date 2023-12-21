<div class="row">
<div class="col-sm-12">
<h4 class="page-title">Услуги</h4>
<ol class="breadcrumb">
<li><a href="/control">Главная</a></li>
<li class="active">Услуги</li>
</ol>
</div>
</div>

<div class="col-sm-12">
<div class="card-box">
<h4 class="m-t-0 header-title"><b>Услуги</b></h4>

<a href="/control/services/add" style="float: right;" class="btn btn-inverse btn-custom btn-rounded waves-effect waves-light btn-xs">Добавить новую услугу</a>


<table class="table table table-hover m-0">
<thead>
<tr>
<th>#</th>
<th>Название</th>
<th>Тип</th>
<th>Период/значение</th>
<th></th>
</tr>
</thead>

<tbody>
<?php foreach($services as $row):?>
<tr id="element<?=$row['id'];?>">
<td><?php echo $row['id'];?></td>
<td><?php echo $row['name'];?></td>
<td><?php if($row['type'] == 'befirst'):?>Befirst<?php elseif($row['type'] == 'top'):?>TOP<?php elseif($row['type'] == 'vip'):?>VIP<?php elseif($row['type'] == 'color'):?>Выделение цветом<?php elseif($row['type'] == 'boost'):?>Буст<?php elseif($row['type'] == 'gamemenu'):?>Gamemenu<?php elseif($row['type'] == 'votes'):?>Голоса<?php elseif($row['type'] == 'razz'):?>Разбан<?php endif;?></td>
<td><?php echo $row['period'];?></td>
<td style="float: right;">
  <a href="/control/services/edit?id=<?=$row['id'];?>" class="text-warning" title="Изменить услугу"><i class="fa fa-pencil"></i></a>

<a href="#" onclick="remove(<?php echo $row['id'];?>); return false;" class="text-danger" title="Удалить услугу"><i class="fa fa-trash"></i></a>
</td>
</tr>
<?php endforeach;?>				
</tbody>
</table>

</div>
</div>
<script>
function remove(id){
    if(confirm("Вы действительно хотите удалить?")){
     $.ajax({
        url: "/control/services/remove",
        data: {'id':id},
        success: function(data){
        setTimeout(location.reload(), 2500);
        }
     });  
    }
}
</script>