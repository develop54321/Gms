<div class="row">
<div class="col-sm-12">
<h4 class="page-title">Добавление новой услуги</h4>
<ol class="breadcrumb">
<li><a href="/control">Главная</a></li>
<li><a href="/control/services">Услуги</a></li>
<li class="active">Добавление новой услуги</li>
</ol>
</div>
</div>

<div class="col-sm-12">
<div class="card-box">
<h4 class="m-t-0 header-title"><b>Добавление новой услуги</b></h4>


<form action="#" id="servicesForm" method="post">
<div class="form-group">
<label for="servicesName">Название услуги</label>
<input type="text" name="servicesName" class="form-control" id="servicesName">
</div>
<div class="form-group">
<label for="servicesName">Тип услуги</label>
<select name="servicesType" class="form-control" id="servicesType" onchange="services();">
<option value="befirst">Befirst</option>
<option value="top">TOP</option>
<option value="vip">VIP</option>
<option value="color">Выделение цветом</option>
<option value="boost">Буст</option>
<option value="gamemenu">Gamemenu</option>
<option value="votes">Голоса</option>
<option value="razz">Разбан сервера</option>
</select>
</div>
	
<div class="form-group" id="servicesPeriod">
<label for="servicesPeriod">Срок услуги(днях)</label>
<input type="int" name="servicesPeriod" class="form-control" >
</div>   
    																			
<div class="form-group">
<label for="servicesPrice">Цена услуги</label>
<input type="int" name="servicesPrice" class="form-control" id="servicesPrice">
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


function services(){
    var type = $("#servicesType").val();
    
    if(type == 'razz'){
    $("#servicesPeriod").hide();
    }else{
    $("#servicesPeriod").show();
    }
}
</script>
