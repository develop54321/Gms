<section class="page">
    <div class="container">
        <h1 class="content-title">
            История платежей
        </h1>
        <hr/>


        <div class="row">

            <div class="col-md-2">
                <?php $url = "paylogs";
                include("UserMenu.tpl"); ?>

            </div>


            <div class="col-md-10">
                <table class="table table table-dark">
                    <thead>
                    <tr>
                        <th scope="col">#</th>
                        <th scope="col">Описание</th>
                        <th scope="col">Дата инициализации</th>
                        <th scope="col">Способ оплаты</th>
                        <th scope="col">Сумма</th>
                        <th scope="col">Статус</th>

                    </tr>
                    </thead>
                    <tbody>
                    <?php foreach ($data as $row): ?>

                        <tr>
                            <td><?php echo $row['id']; ?></td>
                            <td>
                                <?php if ($row['type_pay'] == 'payApi'): ?>
                                    <b>[API]</b><?php endif; ?> <?php echo $row['servicesName']; ?>
                                (<?php if ($row['type_pay'] == 'refill'): ?>id пользователя<?php elseif ($row['type_pay'] == 'payServices' or $row['type_pay'] == 'payApi'): ?>id сервера<?php endif; ?>
                                #<?php echo $row['id_object']; ?>)
                            </td>
                            <td><?php echo date("d.m.Y [H:i]", $row['date_create']); ?></td>
                            <td>
                                <?php echo \widgets\pay_method\PatMethod::run($row['pay_methods']); ?>
                            </td>
                            <td><?php echo \widgets\money\Money::run($row['price']); ?></td>
                            <td>
                                <?php widgets\user\paylogs\status\Status::run($row['status']); ?>
                            </td>


                        </tr>
                    <?php endforeach; ?>

                    </tbody>
                </table>

                <div class="pagination">
                    <nav aria-label="Pagination">
                        <ul class="pagination justify-content-center">
                            <?= implode("\n", $pagination_html) ?>
                        </ul>
                    </nav>
                </div>
            </div>


        </div>
    </div>
</section>