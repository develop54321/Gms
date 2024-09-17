<section class="content mt-5">
  <div class="container">
<nav aria-label="breadcrumb">
  <ol class="breadcrumb">
    <li class="breadcrumb-item"><a href="/">Главная</a></li>
    <li class="breadcrumb-item active" aria-current="page">Платные услуги</li>
  </ol>
</nav>

    <div class="row">

      <div class="col-md-2">
        <?php $url = "pay"; include("UserMenu.tpl");?>

      </div>

      <div class="col-md-10">


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
<?php if($s['type'] == 'razz'):?>
<?php if($serverInfo['ban'] == 0):?>
<option value="<?php echo $s['id'];?>" disabled=""><?php echo $s['name'];?></option>
<?php else:?>
<option value="<?php echo $s['id'];?>"><?php echo $s['name'];?></option>
<?php endif;?>
<?php else:?>
<?php if($serverInfo['ban'] == 0):?>
<?php if($s['type'] == 'befirst' and $settings['global_settings']['befirst_on'] == 1):?><option value="<?php echo $s['id'];?>"><?php echo $s['name'];?></option><?php endif;?>
<?php if($s['type'] == 'top' and $settings['global_settings']['top_on'] == 1):?><option value="<?php echo $s['id'];?>"><?php echo $s['name'];?></option><?php endif;?>
<?php if($s['type'] == 'boost' and $settings['global_settings']['boost_on'] == 1):?><option value="<?php echo $s['id'];?>"><?php echo $s['name'];?></option><?php endif;?>
<?php if($s['type'] == 'vip' and $settings['global_settings']['vip_on'] == 1):?><option value="<?php echo $s['id'];?>"><?php echo $s['name'];?></option><?php endif;?>
<?php if($s['type'] == 'color' and $settings['global_settings']['color_on'] == 1):?><option value="<?php echo $s['id'];?>"><?php echo $s['name'];?></option><?php endif;?>
<?php if($s['type'] == 'gamemenu' and $settings['global_settings']['gamemenu_on'] == 1):?><option value="<?php echo $s['id'];?>"><?php echo $s['name'];?></option><?php endif;?>
<?php if($s['type'] == 'votes' and $settings['global_settings']['votes_on'] == 1):?><option value="<?php echo $s['id'];?>"><?php echo $s['name'];?></option><?php endif;?>
<?php endif;?>
<?php endif;?>
<?php endforeach;?>
</select>
</div>
</div>


<div id="contentForm"></div>
</form>

      </div>



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
						setTimeout('document.location.replace("/result/success")', 1000);
                        break;
                        

                    }
                },
            }); 
</script>
<?php endif;?>

  </div>
  </div>
</section>