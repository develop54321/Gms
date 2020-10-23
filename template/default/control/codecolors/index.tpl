<div class="row">
<div class="col-sm-12">
<h4 class="page-title">Цвета</h4>
<ol class="breadcrumb">
<li><a href="/control">Главная</a></li>
<li class="active">Цвета</li>
</ol>
</div>
</div>


<div class="col-md-12">

<div class="card-box">
<h4 class="m-t-0 header-title"><b>Настройки цветов</b></h4>
<a href="/control/codecolors/add" style="float: right;" class="btn btn-inverse btn-custom btn-rounded waves-effect waves-light btn-xs">Добавить новый цвет</a>


<table class="table m-0">
  <thead>
    <tr>
      <th scope="col">#</th>
      <th scope="col">Название</th>
      <th scope="col">HTML Код</th>
      <th scope="col">Активность</th>
      <th scope="col"></th>
    </tr>
  </thead>
  <tbody>
   <?php foreach($CodeColors as $row):?>
   
     <tr id="server<?php echo $row['id'];?>" style="background: <?php echo $row['code'];?>;color: #212529;">
		<td><?php echo $row['id'];?><input type="hidden" name="id[]" value="<?php echo $row['id'];?>"></td>
		<td><?php echo $row['name'];?></td>
		<td><?php echo $row['code'];?></td>
		<td>
		<?php if($row['activ'] == 1):?>Активен<?php elseif($row['activ'] == 0):?>Не активен<?php endif;?>
		
		</td>
		<td>
		<a href="/control/codecolors/edit?id=<?=$row['id'];?>" class="text-muted" title="Изменить комментария"><i class="fa fa-pencil"></i></a>
		<a href="#" onclick="remove(<?=$row['id'];?>); return false;" class="text-muted" title="Удалить комментария"><i class="fa fa-trash"></i></a>
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
        url: "/control/codecolors/remove",
        data: {'id':id},
        success: function(){
        $('#server'+id+'').hide(300);
        }
     });  
    }
}
</script>
