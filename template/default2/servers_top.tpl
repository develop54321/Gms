<?php

include_once("top_welcome_text.tpl");
?>

<div class="top-servers section mb-3">
    <div class="container">
        <div class="section-head d-flex align-items-center justify-content-between mb-3">
            <h3 class="section-title"><i class="fa fa-star"></i> Топ сервера</h3>
        </div>

        <div class="top-grid">
            <?php foreach ($topServers as $row): ?>
                <?php $link = $row['id'] != null ? "/server/{$row['ip']}:{$row['port']}/info" : "/pay"; ?>
                <div class="top-card"<?php if ($row['color_enabled'] != null): ?> style="box-shadow: inset 3px 0 0 <?php echo $row['color_enabled']; ?>;"<?php endif; ?>>
                    <div class="top-card-banner">
                        <span class="hostname"><a href="<?php echo $link; ?>"><?php echo \widgets\server\hostname\Hostname::run($row['hostname']); ?></a></span>
                    </div>
                    <div class="top-card-map">
                        <a href="<?php echo $link; ?>">
                            <img src="<?php echo $row['img_map']; ?>" alt="<?php echo $row['map']; ?>"/>
                        </a>
                        <?php if ($row['map'] !== null): ?>
                            <div class="map-name"><?php echo $row['map']; ?></div>
                        <?php endif; ?>
                    </div>
                    <div class="top-card-info">
                        <span class="players"><i class="fa fa-users"></i> <?php echo $row['players']; ?>/<?php echo $row['max_players']; ?></span>
                        <span class="addr"><?php echo $row['ip']; ?>:<?php echo $row['port']; ?></span>
                    </div>
                </div>
            <?php endforeach; ?>
        </div>
    </div>
</div>