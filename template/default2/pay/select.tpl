<section class="page">
    <div class="container">
        <h1 class="content-title">
            Заказ платной услуги
        </h1>
        <hr/>

        <style>
            a{
                color: #fff;
                text-decoration: none;
            }
            .card {
                background: rgb(0 0 0 / 28%);
                cursor: pointer;
                border: 1px solid #000000;
                color: #fff;
                cursor: pointer; /* Добавляем курсор в виде указателя */
            }

            .card.active {
                background: rgb(78 78 78 / 53%);
            }
        </style>

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
                                <p class="card-text">With supporting text below as a natural lead-in to additional content.</p>
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
                url: "/pay/form",
                data: {'id_services': id_services, 'id_server': <?php echo $serverInfo['id']; ?>},
                success: function (data) {
                    $("#contentForm").html(data);
                },
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