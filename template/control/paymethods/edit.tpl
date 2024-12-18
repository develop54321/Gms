<div class="row">
<div class="col-sm-12">
<h4 class="page-title">Изменение платежной системы</h4>
<ol class="breadcrumb">
<li><a href="/control">Главная</a></li>
<li><a href="/control/paymethods">Способы оплаты</a></li>
<li class="active">Изменение платежной системы</li>
</ol>
</div>
</div>

<div class="col-sm-12">
<div class="card-box">
<h4 class="m-t-0 header-title"><b>Изменение платежной системы</b></h4>

<div class="row">
<form action="#" id="servicesForm" method="post">
<div class="col-md-6">
<div class="form-group">
<label for="status">Статус</label>
<select name="status" class="form-control" id="status">
<option value="1">Включено</option>
<option value="0" <?php if($data['status'] == '0'):?>selector<?php endif;?>>Отключено</option>
</select>
</div>

<div class="form-group text-right m-b-0">
<button class="btn btn-warning waves-effect waves-light" type="submit">
Изменить
</button>


</div>
</div>

<div class="col-md-6">
<?php if($data['typeCode'] == 'robokassa'):?>
<div class="form-group">
<label for="status">login</label>
<input type="text" class="form-control" name="login" value="<?=$params['login'] ?? null;?>">
</div>

<div class="form-group">
<label for="password1">password 1</label>
<input type="text" class="form-control" id="password1" name="password1" value="<?=$params['password1'] ?? null;?>">
</div>

<div class="form-group">
<label for="password2">password 2</label>
<input type="text" class="form-control" id="password2" name="password2" value="<?=$params['password2'] ?? null;?>">
</div>

<code>
Обработчик: <?php echo $url;?>/result?type=robokassa
</code>

<?php elseif($data['typeCode'] == 'unitpay'):?>
<div class="form-group">
<label for="status">PUBLIC KEY</label>
<input type="text" class="form-control" name="public_key" value="<?=$params['public_key'] ?? null;?>">
</div>

<div class="form-group">
<label for="status">SECRET KEY</label>
<input type="text" class="form-control" name="secret_key" value="<?=$params['secret_key'] ?? null;?>">
</div>

<code>
Обработчик: <?php echo $url;?>/result?type=unitpay
</code>


<?php elseif($data['typeCode'] == 'freekassa'):?>
<div class="form-group">
<label for="status">fk_id</label>
<input type="text" class="form-control" name="fk_id" value="<?=$params['fk_id'] ?? null;?>">
</div>

<div class="form-group">
<label for="fk_key1">fk_key1</label>
<input type="text" class="form-control" id="fk_key1" name="fk_key1" value="<?=$params['fk_key1'] ?? null;?>">
</div>

<div class="form-group">
<label for="fk_key2">fk_key2</label>
<input type="text" class="form-control" id="fk_key2" name="fk_key2" value="<?=$params['fk_key2'] ?? null;?>">
</div>

<code>
Обработчик: <?php echo $url;?>/result?type=freekassa
</code>

    <?php elseif($data['typeCode'] == 'yoomoney'):?>
    <div class="form-group">
        <label for="status">Кошелек получателя</label>
        <input type="text" class="form-control" name="receiver" value="<?=$params['receiver'] ?? null;?>">
    </div>

    <div class="form-group">
        <label for="fk_key1">Секретный ключ</label>
        <input type="text" class="form-control" name="secret_key" value="<?=$params['secret_key'] ?? null;?>">
    </div>


    <code>
        Обработчик: <?php echo $url;?>/result?type=yoomoney
    </code>



    <?php elseif($data['typeCode'] == 'yookassa'):?>
    <div class="form-group">
        <label for="status">shop id</label>
        <input type="text" class="form-control" name="shop_id" value="<?=$params['shop_id'] ?? null;?>">
    </div>

    <div class="form-group">
        <label for="fk_key1">Секретный ключ</label>
        <input type="text" class="form-control" name="secret_key" value="<?=$params['secret_key'] ?? null;?>">
    </div>

    <?php endif;?>

</div>
</form>
</div>





										

        				                        				
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
