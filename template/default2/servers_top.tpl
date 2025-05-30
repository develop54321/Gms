<?php

include_once("top_welcome_text.tpl");
?>

<div class="top-servers mb-3">


    <div class="container">
        <div class="title">
            <h3>
                <i class="fa fa-star-o"></i> Топ сервера
            </h3>


        </div>

        <div class="top-servers-wrapper">
            <div class="row">
                <?php foreach ($topServers as $row): ?>
                    <div class="col-12 col-sm-6 col-md-4 col-lg-3 col-xl-2 block mb-2">
                        <div class="top-servers-info">
                            <div class="hostname"
                                 <?php if ($row['color_enabled'] != null): ?>style="background: <?php echo $row['color_enabled']; ?>
                                         "<?php endif; ?>><a
                                        href="<?php if ($row['id'] != null): ?>/server/<?php echo $row['ip']; ?>:<?php echo $row['port']; ?>/info<?php else: ?>/pay<?php endif; ?>"><?php echo \widgets\server\hostname\Hostname::run($row['hostname']); ?></a>
                            </div>
                            <div class="image-map">
                                <a href="<?php if ($row['id'] != null): ?>/server/<?php echo $row['ip']; ?>:<?php echo $row['port']; ?>/info<?php else: ?>/pay<?php endif; ?>">
                                    <img src="<?php echo $row['img_map']; ?>"/>
                                </a>
                                <?php if ($row['map'] !== null): ?>
                                    <div class="name-map"><?php echo $row['map']; ?></div>
                                <?php endif; ?>
                            </div>

                            <div class="info">
                                <div class="players">
                                    Игроки: <i class="fa fa-users"></i> <?php echo $row['players']; ?>
                                    /<?php echo $row['max_players']; ?>
                                </div>
                                <div class="address"
                                     <?php if ($row['color_enabled'] != null): ?>style="background: <?php echo $row['color_enabled']; ?>
                                             "<?php endif; ?>><?php echo $row['ip']; ?>:<?php echo $row['port']; ?>
                                </div>
                            </div>
                        </div>
                    </div>
                <?php endforeach; ?>
            </div>
        </div>
    </div>
</div>