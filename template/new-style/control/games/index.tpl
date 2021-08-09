<div class="row">
<div class="col-sm-12">
<h4 class="page-title">Игры</h4>
<ol class="breadcrumb">
<li><a href="/control">Главная</a></li>
<li class="active">Игры</li>
</ol>
</div>
</div>

<div class="col-sm-12">
<div class="card-box">
<h4 class="m-t-0 header-title"><b>Игры</b></h4>
<a href="/control/games/add" style="float: right;" class="btn btn-inverse btn-custom btn-rounded waves-effect waves-light btn-xs">Добавить новую игру</a>


<table class="table table table-hover m-0">
<thead>
<tr>
<th>#</th>
<th>Название</th>
<th>Статус</th>
<th></th>
</tr>
</thead>

<tbody>
<?php foreach($games as $row):?>
<tr id="game<?=$row['id'];?>">
<td><?=$row['id'];?></td>
<td><?=$row['game'];?></td>
<td><span class="label label-success">Активный</span></td>
<td style="text-align: right;">
<a href="#" onclick="remove(<?=$row['id'];?>); return false;" class="text-muted" title="Удалить игру"><i class="fa fa-trash"></i></a>

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
        url: "/control/games/remove",
        data: {'id':id},
        success: function(data){
        $('#game'+id+'').hide(300);
        }
     });  
    }
}
</script>