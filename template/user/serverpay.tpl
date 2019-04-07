<div class="content">
<nav aria-label="breadcrumb">
  <ol class="breadcrumb">
    <li class="breadcrumb-item"><a href="/">Главная</a></li>
    <li class="breadcrumb-item active" aria-current="page">Платные услуги</li>
  </ol>
</nav>

<?php $url = "null"; include("UserMenu.tpl");?>


<?php if($type == 'selectServices'):?>
<?php if(empty($services)):?>
<h3 style="text-align: center;">Нету достные услуг для заказа</h3>
<?php else:?>
<h4>Выбранный вами сервер: <?php echo $serverInfo['hostname'];?></h4>
<?php endif;?>
<form method="POST" id="serverpay" action="/user/serverpay?id=<?php echo $serverInfo['id'];?>&step=2">
<div class="form-row">
<div class="col-md-5">
<h4>Выберите услугу:</h4>
<select class="form-control form-control-sm" id="id_services" name="id_services" onclick="updateForm();">
<option>-------------</option>
<?php foreach($services as $s):?>
<option value="<?php echo $s['id'];?>"><?php echo $s['name'];?></option>
<?php endforeach;?>
</select>
</div>
</div>


<div id="contentForm"></div>
</form>



<script>
function updateForm(){
    id_services = $("#id_services").val();
    $.ajax({
       url: "/user/getform",
       data: {'id_services':id_services, 'id_server':<?php echo $serverInfo['id'];?>},
       success: function(data){
        $("#contentForm").html(data);
       }, 
    });
}

     $('#serverpay').ajaxForm({ 
                dataType: "json",
                success: function(data){
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
<?php endif;?>

</div>