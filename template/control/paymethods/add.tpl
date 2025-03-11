<div class="page-header">
    <div>
        <h1 class="page-title">Добавление платежной системы</h1>
    </div>
    <div class="ms-auto pageheader-btn">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="/control">Главная</a></li>
            <li class="breadcrumb-item"><a href="/control/paymethods">Способы оплат</a></li>
            <li class="breadcrumb-item active" aria-current="page">Добавление платежной системы</li>
        </ol>
    </div>
</div>

<div class="card p-0">
    <div class="card-header border-bottom">
        <h5 class="card-title">Добавление платежной системы</h5>
    </div>

    <div class="card-body">


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
