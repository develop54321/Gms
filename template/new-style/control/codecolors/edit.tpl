<div class="row">
<div class="col-sm-12">
<h4 class="page-title">Изменение цвета</h4>
<ol class="breadcrumb">
<li><a href="/control">Главная</a></li>
<li><a href="/control/codecolors">Цвета</a></li>
<li class="active">Изменение цвета</li>
</ol>
</div>
</div>

<div class="col-sm-12">
<div class="card-box">
<h4 class="m-t-0 header-title"><b>Изменение цвета</b></h4>

<div class="row">
<form action="#" id="codecolorsForm" method="post">



<div class="form-group">
<label for="moderation">Активность</label>
<select name="activ" class="form-control" id="activ">
<option value="1">Активен</option>
<option value="0" <?php if($data['activ'] == '0'):?>selected<?php endif;?>>Не активен</option>
</select>
</div>

<div class="form-group">
<label for="name">Цвет</label>
<input type="int" name="name" class="form-control" value="<?=$data['name'];?>"/>
</div>

<div class="form-group">
<label for="code">HTML Код</label>
<input type="int" name="code" class="form-control" value="<?=$data['code'];?>"/>
</div>

<div class="form-group text-right m-b-0">
<button class="btn btn-warning waves-effect waves-light" type="submit">
Изменить
</button>
</div>
</div>
</form>     				                        				
</div>
</div>

<script>
$('#codecolorsForm').ajaxForm({
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
</script>
