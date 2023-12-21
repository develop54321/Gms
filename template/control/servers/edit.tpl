<div class="row">
<div class="col-sm-12">
<h4 class="page-title">Изменение сервера</h4>
<ol class="breadcrumb">
<li><a href="/control">Главная</a></li>
<li><a href="/control/servers">Серверы</a></li>
<li class="active">Изменение сервера</li>
</ol>
</div>
</div>

<div class="col-sm-12">
<div class="card-box">
<h4 class="m-t-0 header-title"><b>Изменение сервера</b></h4>

<div class="row">
<form action="#" id="servicesForm" method="post">
<div class="col-md-6">
<div class="form-group">
<label for="status">Статус</label>
<select name="status" class="form-control" id="status">
<option value="1">Включено</option>
<option value="0" <?php if($data['status'] == '0'):?>selected<?php endif;?>>Отключено</option>
</select>
</div>

<div class="form-group">
<label for="moderation">Модерация</label>
<select name="moderation" class="form-control" id="moderation">
<option value="1">Показывается</option>
<option value="0" <?php if($data['moderation'] == '0'):?>selected<?php endif;?>>Отклонено</option>
</select>
</div>
 
 
<div class="form-group">
<label for="game">Игра</label>
<select name="game" class="form-control" id="game">
<?php foreach($games as $row):?>
<option value="<?php echo $row['code'];?>" <?php if($data['game'] == $row['code']):?>selected<?php endif;?>><?php echo $row['game'];?></option>
<?php endforeach;?>
</select>
</div>

<div class="form-group">
<label for="ip">Ип</label>
<input type="text" name="ip" class="form-control" id="ip" value="<?=$data['ip'];?>">
</div>


<div class="form-group">
<label for="port">Порт</label>
<input type="text" name="port" class="form-control" id="port" value="<?=$data['port'];?>">
</div>

<div class="form-group">
<label for="rating">Рейтинг</label>
<input type="number" name="rating" class="form-control" id="rating" value="<?=$data['rating'];?>">
</div>


<div class="form-group">
<label for="ban">Сервер в бане?</label>
<select class="form-control" name="ban">
<option value="1">Да</option>
<option value="0" <?php if($data['ban'] == '0'):?>selected<?php endif;?>>Нет</option>
</select>
</div>

<div class="form-group">
<label for="ban_couse">Причина бана</label>
<input type="text" name="ban_couse" class="form-control" id="ban_couse" value="<?=$data['ban_couse'];?>">
</div>


<div class="form-group">
<label for="delite_services">Удалить все платные услуги?</label>
<select class="form-control" name="delite_services">
<option value="0">Нет</option>
<option value="1">Да</option>
</select>
</div>


<div class="form-group text-right m-b-0">
<button class="btn btn-warning waves-effect waves-light" type="submit">
Изменить
</button>


</div>
</div>

<div class="col-md-6">


<div class="form-group">
<label for="befirst_expired_date">Время истечения</label>
<input type="date" class="form-control" name="befirst_expired_date" value="<?php echo date("Y-m-d", $data['befirst_expired_date']);?>">
</div>


<div class="form-group">
<label for="top_enabled">TOP</label>
<select class="form-control" name="top_enabled">
<option value="0">Не выбрана</option>
<?php foreach($topPlaces as $t):?>
<option value="<?=$t['id'];?>" <?php if($t['status'] == '1' && $t['currentServer'] == false):?>disabled<?php endif;?><?php if($data['top_enabled'] == $t['id']):?>selected<?php endif;?>>Место #<?=$t['id'];?></option>
<?php endforeach;?>
</select>
</div>

<div class="form-group">
<label for="top_expired_date">Время истечения</label>
<input type="date" class="form-control" name="top_expired_date" value="<?php echo date("Y-m-d", $data['top_expired_date']);?>">
</div>



<div class="form-group">
<label for="vip_enabled">VIP</label>
<select class="form-control" name="vip_enabled">
<option value="1">Да</option>
<option value="0" <?php if($data['vip_enabled'] == '0'):?>selected<?php endif;?>>Нет</option>
</select>
</div>

<div class="form-group">
<label for="vip_expired_date">Время истечения</label>
<input type="date" class="form-control" name="vip_expired_date" value="<?php echo date("Y-m-d", $data['vip_expired_date']);?>">
</div>


<div class="form-group">
<label for="gamemenu_enabled">GameMenu</label>
<select class="form-control" name="gamemenu_enabled">
<option value="1">Да</option>
<option value="0" <?php if($data['gamemenu_enabled'] == '0'):?>selected<?php endif;?>>Нет</option>
</select>
</div>

<div class="form-group">
<label for="gamemenu_expired_date">Время истечения</label>
<input type="date" class="form-control" name="gamemenu_expired_date" value="<?php echo date("Y-m-d", $data['gamemenu_expired_date']);?>">
</div>



<div class="form-group">
<label for="color_enabled">Выделение цветом(код цвета пример: red)</label>
<input type="text" name="color_enabled" class="form-control" id="color_enabled" value="<?=$data['color_enabled'];?>">
</div>

<div class="form-group">
<label for="color_expired_date">Время истечения</label>
<input type="date" class="form-control" name="color_expired_date" value="<?php echo date("Y-m-d", $data['color_expired_date']);?>">
</div>


<div class="form-group">
<label for="boost">Boost кол-во кругов</label>
<input type="number" class="form-control" name="boost" value="<?php echo $data['boost'];?>">
</div>




</div>

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
    if(type == 'color'){
        $("#moreParams").show();
    }else{
        $("#moreParams").hide();
    }
}
</script>
