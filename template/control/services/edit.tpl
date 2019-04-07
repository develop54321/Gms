<div class="row">
<div class="col-sm-12">
<h4 class="page-title">Изменение услуги</h4>
<ol class="breadcrumb">
<li><a href="/control">Главная</a></li>
<li><a href="/control/services">Услуги</a></li>
<li class="active">Изменение услуги</li>
</ol>
</div>
</div>

<div class="col-sm-12">
<div class="card-box">
<h4 class="m-t-0 header-title"><b>Изменение услуги</b></h4>


<form action="#" id="servicesForm" method="post">
<div class="form-group">
<label for="servicesName">Название услуги</label>
<input type="text" name="servicesName" class="form-control" id="servicesName" value="<?php echo $data['name'];?>">
</div>
<div class="form-group">
<label for="servicesName">Тип услуги</label>
<select name="servicesType" class="form-control" id="servicesType" onchange="services();">
<option value="top">TOP</option>
<option value="vip" <?php if($data['type'] == 'vip'):?>selected=""<?php endif;?>>VIP</option>
<option value="color" <?php if($data['type'] == 'color'):?>selected=""<?php endif;?>>Выделение цветом</option>
<option value="boost" <?php if($data['type'] == 'boost'):?>selected=""<?php endif;?>>Буст</option>
<option value="votes" <?php if($data['type'] == 'votes'):?>selected=""<?php endif;?>>Голоса</option>
<option value="razz" <?php if($data['type'] == 'razz'):?>selected=""<?php endif;?>>Разбан сервера</option>
</select>
</div>
	
<div class="form-group">
<label for="servicesPeriod">Срок услуги(днях)</label>
<input type="int" name="servicesPeriod" class="form-control" id="servicesPeriod" value="<?php echo $data['period'];?>">
</div>   
    																			
<div class="form-group">
<label for="servicesPrice">Цена услуги</label>
<input type="int" name="servicesPrice" class="form-control" id="servicesPrice" value="<?php echo $data['price'];?>">
</div>

<div class="form-group" id="moreParams" style="display: none;">
<label for="servicesParams">Дополнительные параметры</label>
<?php $colors = json_decode($data['params'], true);?>
<textarea name="servicesParams" class="form-control" rows="4">
<?php if(!empty($colors)):?>
<?php foreach($colors as $key => $val):?>
<?=$val."\n";?>
<?php endforeach;?>
<?php endif;?>
</textarea>
<span class="help-block"><small>Каждый цвет пишется с новой строки</small></span>
</div>

<div class="form-group text-right m-b-0">
<button class="btn btn-warning waves-effect waves-light" type="submit">
Изменить
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
    var type = $("#servicesType").val();
    if(type == 'color'){
        $("#moreParams").show();
    }else{
        $("#moreParams").hide();
    }
    
    if(type == 'razz'){
    $("#servicesPeriod").hide();
    }else{
    $("#servicesPeriod").show();
    }
}
</script>
