<section class="page pay-select">
    <div class="container">
        <h1 class="content-title">
            Заказ платной услуги
        </h1>
        <hr/>

        <?php echo \widgets\flash\Flash::run(); ?>
        <?php if (empty($services)): ?>
            <h3 style="text-align: center;">Нету доступных услуг для заказа</h3>
        <?php else: ?>
            <h4>Выбранный вами сервер: <?php echo $serverInfo['hostname']; ?></h4>
        <?php endif; ?>

        <hr/>
        <p>Выберите услугу</p>
        <div class="row">
            <?php foreach ($services as $service): ?>
                <div class="col-sm-3 mb-3">
                    <a href="#" onclick="loadForm(<?php echo $service['id']; ?>); toggleActive(this); return false;">
                        <div class="card">
                            <div class="card-body">
                                <h5 class="card-title"><?php echo $service['name']; ?></h5>
                                <p class="card-text"><?php echo $service['text']; ?></p>
                            </div>
                        </div>
                    </a>
                </div>
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
            // Убираем класс active у всех карточек
            document.querySelectorAll('.card').forEach(card => {
                card.classList.remove('active');
            });

            // Добавляем класс active к текущей карточке
            element.querySelector('.card').classList.add('active');
        }
    </script>
<?php endif; ?>