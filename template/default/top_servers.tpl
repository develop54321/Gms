<div class="name-block">
<i class="fa fa-star-o"></i> Топ сервера
</div>

<div class="top-servers">

<?php foreach($topServers as $row):?>
<div class="item">
<div class="hostname" <?php if ($row['color_enabled'] != null):?>style="background: <?php echo $row['color_enabled'];?>"<?php endif;?>><a href="<?php if($row['id'] != null):?>/server/<?php echo $row['ip'];?>:<?php echo $row['port'];?>/info<?php else:?>/pay<?php endif;?>"><?php echo $row['hostname'];?></a></div>
<div class="image-map">
    <a href="<?php if($row['id'] != null):?>/server/<?php echo $row['ip'];?>:<?php echo $row['port'];?>/info<?php else:?>/pay<?php endif;?>">
        <img src="<?php echo $row['img_map'];?>"/>
    </a>
<div class="name-map"><?php echo $row['map'];?></div>
</div>

<div class="info">
<div class="players">
Игроки: <i class="fa fa-users"></i> <?php echo $row['players'];?>/<?php echo $row['max_players'];?>
</div>

<div class="address" <?php if($row['color_enabled'] != null):?>style="background: <?php echo $row['color_enabled'];?>"<?php endif;?>>
<?php echo $row['ip'];?>:<?php echo $row['port'];?>
</div>

</div>
</div>

<?php endforeach;?>


</div>
<div class="clearfix"></div>
