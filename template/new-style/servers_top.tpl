<section class="top-servers">

    <div class="container">
        <div class="name-block text-center">
            <i class="fa fa-star-o"></i> Топ сервера
        </div>

        <div class="top-servers-wrapper">
            <div class="row">
                <?php foreach($topServers as $row):?>

                <div class="col-3" style="width: 20%">
                    <div class="top-servers-info">
                    <div class="hostname"
                    <?php if ($row['color_enabled'] != null):?>style="background: <?php echo $row['color_enabled'];?>
                    "<?php endif;?>><a
                            href="<?php if($row['id'] != null):?>/server/info?id=<?php echo $row['id'];?><?php else:?>/pay<?php endif;?>"><?php echo $row['hostname'];?></a>
                </div>
                <div class="image-map">
                    <a href="<?php if($row['id'] != null):?>/server/info?id=<?php echo $row['id'];?><?php else:?>/pay<?php endif;?>">
                        <img src="<?php echo $row['img_map'];?>"/>
                    </a>
                    <?php if ($row['map'] !== null):?>
                    <div class="name-map"><?php echo $row['map'];?></div>
                    <?php endif;?>
                </div>

                <div class="info">
                    <div class="players">
                        Игроки: <i class="fa fa-users"></i> <?php echo $row['players'];?>
                        /<?php echo $row['max_players'];?>
                    </div>

                    <div class="address"
                    <?php if($row['color_enabled'] != null):?>style="background: <?php echo $row['color_enabled'];?>
                    "<?php endif;?>>
                    <?php echo $row['ip'];?>:<?php echo $row['port'];?>
                </div>
                </div>
            </div>
        </div>


        <?php endforeach;?>
    </div>


</section>