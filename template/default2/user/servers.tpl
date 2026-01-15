<section class="page">
    <div class="container">
        <h1 class="content-title">
            Мои сервера
        </h1>
        <hr/>


        <div class="row">

            <div class="col-md-2">
                <?php $url = "servers";
                include("UserMenu.tpl"); ?>

            </div>

            <div class="col-md-10">
                <div class="alert alert-warning">
                    <b>Как добавить свой сервер?</b>
                    <p>При добавлении сервера через сайт в авторизованном режиме вы автоматически становитесь владельцем этого сервера.</p>
                </div>

                <div class="servers-list">
                <table class="table table-dark">
                    <thead>
                    <tr>
                        <th>id</th>
                        <th>Игра</th>
                        <th>Название</th>
                        <th>Адрес</th>
                        <th>Карта</th>
                        <th>игроки</th>
                        <th>Статус</th>
                        <th></th>
                    </tr>
                    </thead>

                    <?php foreach ($servers as $row): ?>
                    <tr>
                        <td><?php echo $row['id']; ?></td>

                        <td>
                            <?php widgets\server\game\GameIcon::run($row['game']);?>
                            <a href="?game=<?=$row['game'];?>"></a>
                        </td>

                        <td>
                            <a class="hostname" href="/server/<?php echo $row['ip']; ?>:<?php echo $row['port']; ?>/info"><?php echo \widgets\server\hostname\Hostname::run($row['hostname']); ?></a>
                        </td>

                        <td>
                            <span class="address"><?php echo $row['ip']; ?>:<?php echo $row['port']; ?></span>
                        </td>

                        <td>
                            <?php echo $row['map']; ?>
                        </td>

                        <td>
                                  <span class="players">
                        <?php echo $row['players'];?>/<?php echo $row['max_players'];?>
                    </span>

                        </td>

                        <td>
                            <?php if ($row['moderation'] == '1'): ?>
                                <span class="badge bg-primary">Показывается</span>
                            <?php else: ?>
                                <span class="badge bg-warning">Ожидает проверки администратором</span>
                            <?php endif; ?>

                            <?php if ($row['ban'] === 1): ?>
                                <span class="badge bg-danger">Бан</span>
                            <?php else: ?>
                                <?php if ($row['status'] === 1): ?>
                                    <span class="badge bg-success">Работает</span>
                                <?php elseif ($row['status'] === 0): ?>
                                    <span class="badge bg-warning">Недоступен</span>
                                <?php endif; ?>
                            <?php endif; ?>
                        </td>



                        <td style="width: 80px;">
                            <a href="#" onclick="ShowModal('<?= $row['id']; ?>', 'serverServices', 'null');return false;" class="btn btn-warning btn-sm">
                                <i class="fa fa-dollar"></i>
                            </a>

                            <a href="#" onclick="remove(<?= $row['id']; ?>); return false;" class="btn btn-danger btn-sm"
                               title="Удалить сервер"><i class="fa fa-trash"></i>
                            </a>

                        </td>
                    </tr>
                    <?php endforeach;?>
                </table>
                </div>

                <?php if (!empty($servers)): ?>
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
<script>
    function remove(id) {
        if (confirm("Вы действительно хотите удалить данный сервер?")) {
            $.ajax({
                url: "/user/removeserver?id=" + id,
                dataType: "json",
                success: function (data) {
                    switch (data.status) {
                        case "error":
                            ShowModal(data.error, 'answer', 'error');
                            break;

                        case "success":
                            ShowModal(data.success, 'answer', 'success');
                            break;


                    }
                },

            });
        }
    }
</script>
