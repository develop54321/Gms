<div class="content">
<nav aria-label="breadcrumb">
  <ol class="breadcrumb">
    <li class="breadcrumb-item"><a href="/">Главная</a></li>
    <li class="breadcrumb-item active" aria-current="page">Листинг серверов</li>
  </ol>
</nav>

<b>[<span class="text-info">TOP</span>] | Занято <?php echo $countTopPlace;?> мест из <?php echo $settings['global_settings']['count_servers_top'];?></b>
<ul class="listing-servers">
<?php foreach($topServers as $t):?>
<?php if($t['status'] == '1'):?>
<li>Место #<?php echo $t['id_position'];?> занято сервером <b><?php echo $t['ip'];?>:<?php echo $t['port'];?></b></li>
<?php else:?>
<li>Место #<?php echo $t['id_position'];?> свободно</li>
<?php endif;?>
<?php endforeach;?>
</ul>

<br />
<b>[<span class="text-danger">VIP</span>] | Занято <?php echo $countVipServers;?> мест из <?php echo $settings['global_settings']['count_servers_vip'];?></b>

<ul class="listing-servers">
<?php $i = 1;?>
<?php foreach($vipServers as $v):?>
<li>Место #<?php echo $i;?> занято сервером <b><?php echo $v['ip'];?>:<?php echo $v['port'];?></b></li>
<?php $i++;?>
<?php endforeach;?>
</ul>

<br />
<b>[<span class="text-success">Boost</span>] | Занято <?php echo $countBoostServers;?> мест из <?php echo $settings['global_settings']['count_servers_boost'];?></b>
<ul class="listing-servers">
<?php $i = 1;?>
<?php foreach($boostServers as $v):?>
<li>Место #<?php echo $i;?> занято сервером <b><?php echo $v['ip'];?>:<?php echo $v['port'];?> | кругов: <?php echo $v['boost'];?></b>  </li>
<?php $i++;?>
<?php endforeach;?>
</ul>

</div>