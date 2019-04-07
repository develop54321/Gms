<div class="row">
<div class="col-sm-12">
<h4 class="page-title">Способы оплаты</h4>
<ol class="breadcrumb">
<li><a href="/control">Главная</a></li>
<li class="active">Способы оплаты</li>
</ol>
</div>
</div>

<div class="col-sm-12">
<div class="card-box">
<h4 class="m-t-0 header-title"><b>Способы оплаты</b></h4>
<a href="/control/paymethods/add" style="float: right;" class="btn btn-inverse btn-custom btn-rounded waves-effect waves-light btn-xs">Добавить новый способ оплаты</a>


<table class="table table table-hover m-0">
<thead>
<tr>
<th>#</th>
<th>Шлюз</th>
<th>Статус</th>
<th></th>
</tr>
</thead>

<tbody>
<?php foreach($paymethods as $row):?>
<tr id="services<?=$row['id'];?>">
<td><?=$row['id'];?></td>
<td><?=$row['name'];?></td>
<td><? if($row['status'] == '1'):?>Подключена<? else:?>Отключена<?php endif;?></td>
<td style="text-align: right;">
<a href="/control/paymethods/edit?id=<?php echo $row['id'];?>" class="text-muted" title="Изменить платежную систему"><i class="fa fa-pencil"></i></a>
<a href="#" onclick="remove(<?=$row['id'];?>); return false;" class="text-muted" title="Удалить платежную систему"><i class="fa fa-trash"></i></a>

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
        url: "/control/paymethods/remove",
        data: {'id':id},
        success: function(){
        $('#services'+id+'').hide(300);
        }
     });  
    }
}
</script>