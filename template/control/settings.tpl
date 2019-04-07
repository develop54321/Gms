<div class="row">
<div class="col-sm-12">
<h4 class="page-title">Настройки</h4>
<ol class="breadcrumb">
<li><a href="/control">Главная</a></li>
<li class="active">Настройки</li>
</ol>
</div>
</div>
<div class="col-sm-12">
<div class="card-box">
<h4 class="m-t-0 header-title"><b>Настройки</b></h4>


<div class="col-lg-12"> 
                                <div class="tabs-vertical-env"> 
                                    <ul class="nav tabs-vertical"> 
                                        <li class="active">
                                            <a href="#v-home" data-toggle="tab" aria-expanded="false">Основные</a>
                                        </li> 
                                      
                                        <li class="">
                                            <a href="#v-comments" data-toggle="tab" aria-expanded="false">Комментарии</a>
                                        </li> 
                                        <li class="">
                                            <a href="#v-settings" data-toggle="tab" aria-expanded="false">Системные</a>
                                        </li> 
                                    </ul> 

<div class="tab-content" style="width: 100%;"> 

<div class="tab-pane active" id="v-home"> 
          <form id="settingsForm" method="post">                              
<div class="row">
 <div class="col-md-6">
<div class="form-group">
<label>Название сайта</label>
<input type="int" name="global_settings[site_name]" class="form-control" value="<?=$settings['global_settings']['site_name'];?>">
</div>

                              

	                                            
<div class="form-group">
<label >Кол-во топовых серверов</label>
<input type="int" name="global_settings[count_servers_top]" class="form-control" value="<?=$settings['global_settings']['count_servers_top'];?>">
</div>

<div class="form-group">
<label >Кол-во вип серверов</label>
<input type="int" name="global_settings[count_servers_vip]" class="form-control" value="<?=$settings['global_settings']['count_servers_vip'];?>">
</div>

<div class="form-group">
<label >Кол-во буст серверов</label>
<input type="int" name="global_settings[count_servers_boost]" class="form-control" value="<?=$settings['global_settings']['count_servers_boost'];?>">
</div>

                     
	                                            
	                           

</div>


 <div class="col-md-6">
 <div class="form-group">
<label>Добавление сервера</label>
<select class="form-control" name="global_settings[auto_add_server]">
<option value="1">Автоматически</option>
<option value="0" <?php if($settings['global_settings']['auto_add_server'] == '0'):?>selected=""<?php endif;?>>Вручную(проверяется администраторм)</option>
</select>
</div>


                                                                     

<div class="form-group">
<label >Кол-во серверов на главной странице</label>
<input type="int" name="global_settings[count_servers_main]" class="form-control" value="<?=$settings['global_settings']['count_servers_main'];?>">
</div>

          
                   				
</div> 
</div>

</div> 


<div class="tab-pane" id="v-comments"> 
<div class="row">
 <div class="col-md-6">
                                                                     
<div class="form-group">
<label>Разрешить гостям оставлять комментарии</label>
<select class="form-control" name="comments[guest_allow]" >
<option value="1">Да</option>
<option value="0" <?php if($settings['comments']['guest_allow'] == '0'):?>selected=""<?php endif;?>>Нет</option>
</select>
</div>


</div>

<div class="col-md-6">
 <div class="form-group">
<label>Добавление комментарии</label>
<select class="form-control" name="comments[moderation]">
<option value="1">Автоматически</option>
<option value="0" <?php if($settings['comments']['moderation'] == '0'):?>selected=""<?php endif;?>>Вручную(проверяется администраторм)</option>
</select>
</div>

</div>


 
</div>
</div>
 
<div class="tab-pane" id="v-settings"> 
<div class="row">
 <div class="col-md-6">
<div class="form-group">
<label>Cron ключ</label>
<input type="text" name="global_settings[cron_key]" class="form-control" value="<?=$settings['global_settings']['cron_key'];?>">
</div>	                                                                                                                                     				
</div> 

<div class="col-md-6">
 <div class="form-group">
<label>Автоматическое создание резервной копии базы</label>
<select class="form-control" name="global_settings[auto_backup_database]">
<option value="1">Да</option>
<option value="0" <?php if($settings['global_settings']['auto_backup_database'] == '0'):?>selected=""<?php endif;?>>Нет</option>
</select>
</div>
</div>

</div>
</div> 


<div class="form-group">
<button type="submit" class="btn btn-primary btn-block text-uppercase waves-effect waves-light">Сохранить</button>
</div>
</form>
	    
                                    </div> 
                                </div> 
                            </div> 



 <div class="clearfix"></div>				
                        	
</div>
</div>

<script>
$('#settingsForm').ajaxForm({
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
</script>