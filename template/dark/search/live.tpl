<?php if (empty($servers)): ?>
    <div class="search-results-empty"><i class="fa fa-search"></i> Ничего не найдено</div>
<?php else: ?>
    <?php foreach ($servers as $row): ?>
        <a href="/server/<?php echo $row['ip'];?>:<?php echo $row['port'];?>/info" class="search-result-item">
            <span class="game-icon"><?php widgets\server\game\GameIcon::run($row['game']);?></span>

            <span class="sri-body">
                <span class="sri-title">
                    <?php echo \widgets\server\hostname\Hostname::run($row['hostname']);?>
                    <?php if ($row['vip_enabled'] !== null): ?><i class="fa fa-star sri-vip"></i><?php endif;?>
                </span>
                <span class="sri-addr">
                    <?php echo $row['host'] ?? $row['ip'];?>:<?php echo $row['port'];?><?php if (!empty($row['map'])): ?> · <?php echo $row['map'];?><?php endif;?>
                </span>
            </span>

            <span class="sri-side">
                <span class="sri-players"><?php echo (int)$row['players'];?>/<?php echo (int)$row['max_players'];?></span>
                <span class="sri-dot <?php echo $row['status'] == 1 ? 'online' : 'offline';?>"></span>
            </span>
        </a>
    <?php endforeach;?>
<?php endif;?>
