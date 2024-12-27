<div class="row">
<div class="col-sm-12">
<h4 class="page-title">Комментарии</h4>
<ol class="breadcrumb">
<li><a href="/control">Главная</a></li>
<li class="active">Комментарии</li>
</ol>
</div>
</div>


<div class="col-sm-12">
<div class="card-box">
<h4 class="m-t-0 header-title"><b>Фильтр</b> <i class="fa fa-filter"></i></h4>
<p class="text-muted m-b-30 font-12">Всего найдено элэментов: <?php echo $filter['count'];?></p>

<form action="/control/comments/search" method="get">
<div class="row">


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
<h4 class="m-t-0 header-title"><b>Комментарии</b></h4>
<p class="text-muted m-b-30 font-12">Комментарии по умолчанию сортируется по дате</p>





<table class="table table table-hover m-0">
  <thead>
    <tr>
      <th scope="col">#</th>
      <th scope="col">Текст</th>
      <th scope="col">Дата добавления</th>
      <th scope="col">Статус</th>
      <th scope="col"></th>
    </tr>
  </thead>
  <tbody>
   <?php foreach($comments as $row):?>
   
    <tr id="server<?php echo $row['id'];?>">
      <td><?php echo $row['id'];?></td>
    
      <td>
      <a style="white-space: nowrap;overflow: hidden;text-overflow: ellipsis;display: block;width: 500px;" target="_blank" href="/server/<?php echo $row['ip'];?>:<?php echo $row['port'];?>/info"><?php echo $row['text'];?></a></td>
      <td>
      <?php echo date("d:m:Y [H:i]", $row['date_create']);?>
      </td>
    
      
    
      <td>
      <?php if($row['moderation'] == '0'):?>
      <label class="label label-warning">Ожидает проверки</label>
      <?php elseif($row['moderation'] == '1'):?>
      <label class="label label-success">Показывается</label>
      <?php endif;?>
      
      </td>
      
      <td>
       <?php if($row['moderation'] == '0'):?>
      <a href="/control/comments/moderation?id=<?=$row['id'];?>" class="btn btn-success btn-xs" title="Одобрить"><i class="fa fa-check"></i></a>
      <?php endif;?>
      
      <a href="/control/comments/edit?id=<?=$row['id'];?>" class="text-muted" title="Изменить комментария"><i class="fa fa-pencil"></i></a>
<a href="#" onclick="remove(<?=$row['id'];?>); return false;" class="text-muted" title="Удалить комментария"><i class="fa fa-trash"></i></a>

      </td>
    </tr>
    <?php endforeach;?>
    
  </tbody>
</table>

    <div class="pagination">
        <nav aria-label="Pagination">
            <ul class="pagination justify-content-center">
                <?= implode("\n", $pagination_html) ?>
            </ul>
        </nav>
    </div>



</div>
</div>

<script>
function remove(id){
    if(confirm("Вы действительно хотите удалить?")){
     $.ajax({
        url: "/control/comments/remove",
        data: {'id':id},
        success: function(){
        $('#server'+id+'').hide(300);
        }
     });  
    }
}
</script>