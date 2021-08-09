<div class="row">
<div class="col-sm-12">
<h4 class="page-title">Добавление новой игры</h4>
<ol class="breadcrumb">
<li><a href="/control">Главная</a></li>
<li><a href="/control/games">Игры</a></li>
<li class="active">Добавление новой игры</li>
</ol>
</div>
</div>

<div class="col-sm-12">
<div class="card-box">
<h4 class="m-t-0 header-title"><b>Добавление новой игры</b></h4>


<form action="#" id="gameForm" method="post">

<div class="form-group">
<label for="game">Игра</label>
<select name="game" class="form-control" id="game" required>
<?php foreach($games as $row):?>
<option value="<?php echo $row['id'];?>"><?php echo $row['game'];?></option>
<?php endforeach;?>
</select>
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
$('#gameForm').ajaxForm({
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
}
</script>
