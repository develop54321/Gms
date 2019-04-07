<div class="row">
<div class="col-sm-12">
<h4 class="page-title">Изменение комментария</h4>
<ol class="breadcrumb">
<li><a href="/control">Главная</a></li>
<li><a href="/control/comments">Комментарии</a></li>
<li class="active">Изменение комментария</li>
</ol>
</div>
</div>

<div class="col-sm-12">
<div class="card-box">
<h4 class="m-t-0 header-title"><b>Изменение комментария</b></h4>

<div class="row">
<form action="#" id="commentsForm" method="post">
<div class="col-md-6">


<div class="form-group">
<label for="moderation">Модерация</label>
<select name="moderation" class="form-control" id="moderation">
<option value="1">Показывается</option>
<option value="0" <?php if($data['moderation'] == '0'):?>selected<?php endif;?>>Отклонено</option>
</select>
</div>

<div class="form-group">
<label for="moderation">Пользователь(id)</label>
<input type="int" name="id_user" class="form-control" value="<?=$data['id_user'];?>"/>
</div>

<div class="form-group">
<label for="moderation">Сервер(id)</label>
<input type="int" name="id_server" class="form-control" value="<?=$data['id_server'];?>"/>
</div>
 

<div class="form-group">
<label for="rating">Текст</label>
<textarea name="text" class="form-control"><?=$data['text'];?></textarea>
</div>

<div class="form-group text-right m-b-0">
<button class="btn btn-warning waves-effect waves-light" type="submit">
Изменить
</button>


</div>
</div>


</div>
</form>




										

        				                        				
</div>

</div>
<script>
$('#commentsForm').ajaxForm({
   dataType: 'json',
   success: function(data) {
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


function services(){
    var type = $("#servicesType").val();
    if(type == 'color'){
        $("#moreParams").show();
    }else{
        $("#moreParams").hide();
    }
}
</script>
