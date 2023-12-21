<div class="row">
<div class="col-sm-12">
<h4 class="page-title">Добавление платежной системы</h4>
<ol class="breadcrumb">
<li><a href="/control">Главная</a></li>
<li><a href="/control/paymethods">Способы оплаты</a></li>
<li class="active">Добавление платежной системы</li>
</ol>
</div>
</div>

<div class="col-sm-12">
<div class="card-box">
<h4 class="m-t-0 header-title"><b>Добавление платежной системы</b></h4>


<form action="#" id="servicesForm" method="post">
<div class="form-group">
<label for="status">Статус</label>
<select name="status" class="form-control" id="status">
<option value="1">Включено</option>
<option value="0">Отключено</option>
</select>
</div>
<div class="form-group">
<label for="type">Платежная система</label>
<select name="type" class="form-control" id="type" onchange="services();" required>
<?php foreach($PayMethods as $row):?>
<option value="<?php echo $row['id'];?>"><?php echo $row['name'];?></option>
<?php endforeach;?>
</select>
</div>
	

<div class="form-group" id="moreParams" style="display: none;">
<label for="servicesParams">Дополнительные параметры</label>
<textarea name="servicesParams" class="form-control" rows="4"></textarea>
<span class="help-block"><small>Каждый цвет пишется с новой строки</small></span>
</div>

<div class="form-group text-right m-b-0">
<button class="btn btn-primary waves-effect waves-light" type="submit">
Добавить
</button>


</div>
										
</form>
        				                        				
</div>

</div>
<script>
$('#servicesForm').ajaxForm({
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

services();
function services(){
    var type = $("#type").val();
    if(type == 'robokassa'){
        $("#moreParams").show();
    }else if(type == 'unitpay'){
        $("#moreParams").hide();
    }
	else if(type == 'freekassa'){
        $("#moreParams").hide();
    }
}
</script>
