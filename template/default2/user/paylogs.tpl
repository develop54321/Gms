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
                        <th scope="col">id</th>
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
                                <span class="address">
                                <?php echo $row['servicesName']; ?>
                                </span>
                            </td>
                            <td><?php echo date("d.m.Y [H:i]", $row['date_create']); ?></td>
                            <td>
                                <span class="address">
                                <?php echo \widgets\pay_method\PatMethod::run($row['pay_methods']); ?>
                                </span>
                            </td>
                            <td><?php echo \widgets\money\Money::run($row['price']); ?></td>
                            <td>
                                <?php widgets\user\paylogs\status\Status::run($row['status']); ?>
                            </td>


                        </tr>
                    <?php endforeach; ?>

                    </tbody>
                </table>

                <?php if (!empty($data)): ?>
                <div class="pagination">
                    <nav aria-label="Pagination">
                        <ul class="pagination justify-content-center">
                            <?= implode("\n", $pagination_html) ?>
                        </ul>
                    </nav>
                </div>
                <?php endif; ?>
            </div>


        </div>
    </div>
</section>