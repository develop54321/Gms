<?php
$typeIcons = [
    'top' => 'fa-arrow-up', 'vip' => 'fa-star', 'color' => 'fa-paint-brush',
    'gamemenu' => 'fa-list', 'votes' => 'fa-thumbs-up', 'razz' => 'fa-unlock', 'boost' => 'fa-bolt',
];
$typeUnits = [
    'top' => 'дней', 'vip' => 'дней', 'color' => 'дней', 'gamemenu' => 'дней',
    'votes' => 'голосов', 'boost' => 'кругов',
];
$typeColors = [
    'top' => ['--accent-strong', '--accent-soft'],
    'vip' => ['--vip', '--vip-soft'],
    'color' => ['--violet', '--violet-soft'],
    'gamemenu' => ['--mint', '--mint-soft'],
    'votes' => ['--cyan', '--cyan-soft'],
    'boost' => ['--warn', '--warn-soft'],
    'razz' => ['--danger', '--danger-soft'],
];
?>
<section class="page pay-select">
    <div class="container">
        <h1 class="content-title">
            Заказ платной услуги
        </h1>
        <hr/>

        <?php echo \widgets\flash\Flash::run(); ?>

        <?php if (isset($serverInfo) && $serverInfo): ?>
            <div class="pay-server-strip">
                <span class="game-icon"><?php widgets\server\game\GameIcon::run($serverInfo['game']);?></span>
                <div class="pay-server-strip-body">
                    <span class="label">Услуга оформляется для сервера</span>
                    <span class="name"><?php echo \widgets\server\hostname\Hostname::run($serverInfo['hostname']); ?></span>
                </div>
                <span class="address"><?php echo $serverInfo['host'] ?? $serverInfo['ip'];?>:<?php echo $serverInfo['port'];?></span>
            </div>
        <?php endif; ?>

        <?php if (empty($services)): ?>
            <div class="empty-hint"><i class="fa fa-info-circle"></i>Нет доступных услуг для заказа</div>
        <?php else: ?>

            <div class="pay-step-title"><span class="pay-step-num">1</span> Выберите услугу</div>

            <div class="service-grid mb-3">
                <?php foreach ($services as $service): ?>
                    <?php
                    $icon = $typeIcons[$service['type']] ?? 'fa-cog';
                    $unit = $typeUnits[$service['type']] ?? null;
                    $hasTiers = !empty($service['tiers_count']);
                    $color = $typeColors[$service['type']] ?? ['--accent-strong', '--accent-soft'];
                    ?>
                    <a href="#" class="service-tile" onclick="loadForm(<?php echo $service['id']; ?>); toggleActive(this); return false;">
                        <div class="card service-card pay-service-card" style="--svc-color: var(<?php echo $color[0]; ?>); --svc-soft: var(<?php echo $color[1]; ?>);">
                            <div class="card-body">
                                <span class="pay-service-ico"><i class="fa <?php echo $icon; ?>"></i></span>
                                <h5 class="card-title"><?php echo $service['name']; ?></h5>
                                <p class="card-text"><?php echo $service['text']; ?></p>
                                <div class="pay-service-price">
                                    <?php if ($hasTiers): ?>
                                        от <?php echo \widgets\money\Money::run($service['min_price']); ?>
                                    <?php else: ?>
                                        <?php echo \widgets\money\Money::run($service['price']); ?>
                                    <?php endif; ?>
                                    <?php if (!$hasTiers && $unit && (int)$service['period'] > 0): ?>
                                        <span class="pay-service-unit">/ <?php echo (int)$service['period']; ?> <?php echo $unit; ?></span>
                                    <?php endif; ?>
                                </div>
                            </div>
                        </div>
                    </a>
                <?php endforeach; ?>
            </div>

            <div id="contentForm"></div>
        <?php endif; ?>
    </div>
</section>

<?php if (isset($serverInfo)): ?>
    <script>
        function loadForm(id_services) {
            $("#contentForm").html('<div class="search-results-loading"><i class="fa fa-spinner fa-spin"></i> Загрузка...</div>');

            $.ajax({
                url: "/pay/<?php echo $serverInfo['id']; ?>/form",
                data: {'id_services': id_services},
                success: function (data) {
                    $("#contentForm").fadeOut(150, function() {
                        $(this).html(data).fadeIn(150);
                        $(this)[0].scrollIntoView({behavior: 'smooth', block: 'nearest'});
                    });
                },
                error: function (err) {
                    console.log(err)
                }
            });
        }

        function toggleActive(element) {
            document.querySelectorAll('.service-card').forEach(card => {
                card.classList.remove('active');
            });

            element.querySelector('.service-card').classList.add('active');
        }
    </script>
<?php endif; ?>
