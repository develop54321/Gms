<div class="row">
<div class="col-sm-12">
<h4 class="page-title">Главная</h4>
<ol class="breadcrumb">
<li class="active">Добро пожаловать в панель управления</li>
</ol>
</div>
</div>



<div class="row">
							<div class="col-lg-6">
								<div class="panel panel-border panel-inverse">
									<div class="panel-heading">
										<h3 class="panel-title">Информация о системе</h3>
									</div>
									<div class="panel-body">
									<ul class="list-group">
                                                <li class="list-group-item">
                                                    <span class="badge badge-primary"><?php echo phpversion();?></span>
                                                    Версия php
                                                </li>
                                                
                                                <li class="list-group-item">
                                                    <span class="badge badge-primary"><?php echo $versionMysql;?></span>
                                                    Версия mysql
                                                </li>
                                                
                                                <li class="list-group-item">
                                                    <span class="badge badge-primary"><?php echo $sizeDatabase;?></span>
                                                    Размер Базы Данных
                                                </li>
                                                
                                                <li class="list-group-item">
                                                    <span class="badge badge-primary"><?php echo date("d:m:Y H:i");?></span>
                                                    Время на сервере
                                                </li>
                                                
                                                <li class="list-group-item">
                                                    <span class="badge badge-primary"><?php echo time()-$settings['last_update_servers'];?> сек.</span>
                                                    Последняя проверка серверов
                                                </li>
                                              
                                            </ul>
									</div>
								</div>
							</div>
                            
                            
                            	<div class="col-lg-6">
								<div class="panel panel-border panel-danger">
									<div class="panel-heading">
										<h3 class="panel-title">Уведомление </h3>
									</div>
									<div class="panel-body">
									<ul class="list-group">
                                     <?php if(empty($notification)):?>
                                     Новых уведомление нету
                                     <?php else:?>
                                     <?php foreach($notification as $n):?>
                                     <?php if($n['type'] == 'moderationServers' && $n['count'] != '0'):?>
                                     <li class="list-group-item">
                                     <span class="badge badge-danger"><?php echo $n['count'];?></span>
                                     Сервера ожидающую проверку: 
                                     </li>
                                     <?php elseif($n['type'] == 'moderationComments' && $n['count'] != '0'):?>
                                     <li class="list-group-item">
                                     <span class="badge badge-danger"><?php echo $n['count'];?></span>
                                     Комментарьев ожидающую проверку: 
                                     </li>
                                     <?php endif;?>
                                     <?php endforeach;?>
                                     <?php endif;?> 
                                             
                                                
                                               
                                                
                                            
                                              
                                                
                                              
                                              
                                            </ul>
									</div>
								</div>
							</div>
                            
                          
						</div>


<div class="row">
  
                            
                            
<div class="col-lg-6">
<div class="panel panel-border panel-primary">
<div class="panel-heading">
<h3 class="panel-title">Статистика </h3>
</div>
<div class="panel-body">
<ul class="list-group">
<?php foreach($counts as $c):?>
<?php if($c['type'] == 'countServers'):?>
<li class="list-group-item"><span class="badge badge-primary"><?php echo $c['countServers'];?></span>Всего серверов в базе: </li>
<?php endif;?>

<?php if($c['type'] == 'countUsers'):?>
<li class="list-group-item"><span class="badge badge-primary"><?php echo $c['countUsers'];?></span>Всего зарегистрированных пользователей: </li>
<?php endif;?>

<?php endforeach;?>      
</ul>
</div>
</div>
</div>
                            
                            

</div>

