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
<h4 class="m-t-0 header-title"><b>Изменение тарифа | услуга <?php echo $data['type'];?></b></h4>


<form action="#" id="servicesForm" method="post">
<div class="form-group">
<label for="servicesName">Название услуги</label>
<input type="text" name="servicesName" class="form-control" id="servicesName" value="<?php echo $data['name'];?>">
</div>

	
<div class="form-group">
<label for="servicesPeriod">Срок услуги(днях)</label>
<input type="int" name="servicesPeriod" class="form-control" id="servicesPeriod" value="<?php echo $data['period'];?>">
</div>   
    																			
<div class="form-group">
<label for="servicesPrice">Цена услуги</label>
<input type="int" name="servicesPrice" class="form-control" id="servicesPrice" value="<?php echo $data['price'];?>">
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
    
    if(type == 'razz'){
    $("#servicesPeriod").hide();
    }else{
    $("#servicesPeriod").show();
    }
}
</script>
