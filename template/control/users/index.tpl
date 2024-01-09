<div class="row">
<div class="col-sm-12">
<h4 class="page-title">Пользователи</h4>
<ol class="breadcrumb">
<li><a href="/control">Главная</a></li>
<li class="active">Пользователи</li>
</ol>
</div>
</div>


<div class="col-sm-12">
<div class="card-box">
<h4 class="m-t-0 header-title"><b>Фильтр</b> <i class="fa fa-filter"></i></h4>


<form action="/control/users/search" method="post">
<div class="row">

<div class="col-md-3">
<div class="form-group">
<label>Email</label>
<input type="email" name="query" class="form-control input-sm" required="">
</div>
</div>
</div>


<button type="submit" class="btn btn-primary waves-effect waves-light btn-sm">
Найти
</button>








</form>
</div>


<div class="card-box">
<h4 class="m-t-0 header-title"><b>Пользователи</b></h4>
<p class="text-muted m-b-30 font-12">Пользователи по умолчанию сортируется по дате регистрации</p>





<table class="table table table-hover m-0">
  <thead>
    <tr>
      <th scope="col">#</th>
      <th scope="col">Имя</th>
      <th scope="col">Email</th>
      <th scope="col">Роль</th>
      <th scope="col">Баланс</th>
      <th scope="col">Дата добавления</th>
      <th scope="col"></th>
    </tr>
  </thead>
  <tbody>
   <?php foreach($users as $row):?>
    <tr id="user<?php echo $row['id'];?>">
      <td><?php echo $row['id'];?></td>
      <td>
      <?php echo $row['firstname'];?> <?php echo $row['lastname'];?>
      </td>
      <td><?php echo $row['email'];?></td>
      <td><?php if($row['role'] == 'admin'):?>
      <span class="badge badge-success">Администратор</span>
      <?php elseif($row['role'] == 'user'):?>
      <span class="badge badge-warning">Пользователь</span>
      <?php elseif($row['role'] == 'partner'):?>
      <span class="badge badge-info">Партнер</span>
      <?php endif;?>
      </td>
      <td><?php echo \widgets\money\Money::run($row['balance']);?></td>
      <td>
      <?php echo date("d:m:Y [H:i]", $row['date_reg']);?>
      </td>
    
      
    
      
      <td>
      <a href="/control/users/edit?id=<?=$row['id'];?>" class="text-muted" title="Изменить пользователя"><i class="fa fa-pencil"></i></a>
<a href="#" onclick="remove(<?=$row['id'];?>); return false;" class="text-muted" title="Удалить пользователя"><i class="fa fa-trash"></i></a>

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
        url: "/control/users/remove",
        data: {'id':id},
        success: function(){
        $('#user'+id+'').hide(300);
        }
     });  
    }
}
</script>