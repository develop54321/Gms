<section class="page banlist">
    <div class="container">
        <h1 class="content-title">
            Банлист
        </h1>
        <hr/>


        <div class="container">


            <div class="alert alert-danger">
                <b>Внимание!</b>
                <p>
                    Все сервера находящиеся в данном списке нарушили одно (или несколько) правил мониторинга.<br/>
                    При попадание сервера в бан, все услуги на нем аннулируются и средства не возвращаются.
                </p>
            </div>
            <table class="table table-dark">
                <thead class="thead-dark">
                <tr>
                    <th scope="col">#</th>
                    <th scope="col">Название</th>
                    <th scope="col">Адрес</th>
                    <th scope="col">Причина</th>
                    <th scope="col" style="text-align: center;">Дата бана</th>
                </tr>
                </thead>
                <tbody>
                <?php foreach ($BannisterServers as $row): ?>
                    <tr>
                        <td><?php echo $row['id']; ?></td>
                        <td>
                            <a href="/server/<?php echo $row['ip']; ?>:<?php echo $row['port']; ?>/info"><?php echo $row['hostname']; ?></a>
                        </td>
                        <td><?php echo $row['ip']; ?>:<?php echo $row['port']; ?></td>
                        <td>
                            <?php echo $row['ban_couse']; ?>
                        </td>
                        <td style="text-align: center;">
                            <?php echo date("d.m.Y [H:i]", $row['ban_date']); ?>
                        </td>
                    </tr>
                <?php endforeach; ?>

                </tbody>
            </table>


        </div>
    </div>
</section>