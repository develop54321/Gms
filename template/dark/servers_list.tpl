<?php \widgets\common\games\menu\Menu::run();?>

<div class="servers-list section">
    <div class="container">

        <div class="section-head d-flex align-items-center justify-content-between mb-3">
            <h3 class="section-title"><i class="fa fa-star"></i> Список серверов</h3>
        </div>

        <div class="table-card">
            <div class="table-responsive">
            <table class="table servers-table mb-0">
                <thead>
                <tr>
                    <th scope="col">Игра</th>
                    <th scope="col">Название</th>
                    <th scope="col">Адрес</th>
                    <th scope="col">Карта</th>
                    <th scope="col">Игроки</th>
                    <th scope="col" style="text-align: center;">Рейтинг</th>
                </tr>
                </thead>
                <tbody>
                <?php foreach($servers as $row):?>
                <tr <?php if($row['color_enabled'] != null):?>class="row-color" style="box-shadow: inset 3px 0 0 <?php echo $row['color_enabled'];?>;"<?php endif;?>>
                <td>
                    <span class="game-icon">
                        <?php widgets\server\game\GameIcon::run($row['game']);?>
                    </span>
                    <a href="?game=<?=$row['game'];?>"></a>
                </td>
                <td><a class="hostname" href="/server/<?php echo $row['ip'];?>:<?php echo $row['port'];?>/info"><?php echo \widgets\server\hostname\Hostname::run($row['hostname']);?></a></td>
                <td>
    <span class="address" id="server-<?=$row['id'];?>">
        <?php echo $row['host'] ?? $row['ip'];?>:<?php echo $row['port'];?>
    </span>
                    <button class="copy-btn" onclick="copyToClipboard('server-<?=$row['id'];?>')">
                        <i class="fa fa-copy"></i>
                    </button>
                </td>
                <td><?php echo $row['map'];?></td>
                <td>
                    <span class="players">
                        <?php echo $row['players'];?>/<?php echo $row['max_players'];?>
                    </span>
                </td>
                <td style="text-align: center;">
                    <?php if($row['vip_enabled'] !== null):?>
                    <span class="badge badge-vip"><i class="fa fa-star"></i> VIP</span>
                    <?php else:?>
                    <div class="rating">
                        <a href="#" onclick="ShowModal('<?=$row['id'];?>', 'vote', 'minus');return false;"><i class="fa fa-thumbs-down"></i></a>
                        <span class="vote">
                            <label id="vote<?php echo $row['id'];?>" class="rating-bg"><?php echo $row['rating'];?></label>
                        </span>
                        <a href="#" onclick="ShowModal('<?=$row['id'];?>', 'vote', 'plus');return false;"><i class="fa fa-thumbs-up"></i></a>
                    </div>
                    <?php endif;?>

                </td>
                </tr>
                <?php endforeach;?>

                </tbody>
            </table>
            </div>
        </div>

        <?php if (!empty($servers)):?>
        <div class="pagination-wrap mt-3">
            <nav aria-label="Pagination">
                <ul class="pagination justify-content-center">
                    <?= implode("\n", $pagination_html) ?>
                </ul>
            </nav>
        </div>
        <?php endif;?>

    </div>
</div>