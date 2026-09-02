<section class="page pay-select">
    <div class="container">
        <h1 class="content-title">
            Заказ платной услуги
        </h1>
        <hr/>

        <?php echo \widgets\flash\Flash::run(); ?>
        <?php if (empty($services)): ?>
            <h3 style="text-align: center;">Нет доступных услуг для заказа</h3>
        <?php else: ?>
            <h4>Выбранный вами сервер: <?php echo \widgets\server\hostname\Hostname::run($serverInfo['hostname']); ?></h4>
        <?php endif; ?>

        <hr/>
        <p class="text-muted mb-3">Выберите услугу</p>
        <div class="service-grid mb-3">
            <?php foreach ($services as $service): ?>
                <a href="#" class="service-tile" onclick="loadForm(<?php echo $service['id']; ?>); toggleActive(this); return false;">
                    <div class="card service-card">
                        <div class="card-body">
                            <h5 class="card-title"><?php echo $service['name']; ?></h5>
                            <p class="card-text"><?php echo $service['text']; ?></p>
                        </div>
                    </div>
                </a>
            <?php endforeach; ?>
        </div>

        <div id="contentForm"></div>
    </div>
</section>

<?php if (isset($serverInfo)): ?>
    <script>
        function loadForm(id_services) {
            $.ajax({
                url: "/pay/<?php echo $serverInfo['id']; ?>/form",
                data: {'id_services': id_services},
                success: function (data) {
                    $("#contentForm").fadeOut(300, function() {
                        $(this).html(data).fadeIn(300);
                    });
                },
                error: function (err) {
                    console.log(err)
                }
            });
        }

        function toggleActive(element) {
            document.querySelectorAll('.card').forEach(card => {
                card.classList.remove('active');
            });

            element.querySelector('.card').classList.add('active');
        }
    </script>
<?php endif; ?>