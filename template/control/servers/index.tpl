<div class="page-header">
    <div>
        <h1 class="page-title">Сервера</h1>
    </div>
    <div class="ms-auto pageheader-btn">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="/control">Главная</a></li>
            <li class="breadcrumb-item active" aria-current="page">Сервера</li>
        </ol>
    </div>
</div>


<div class="card p-0">
    <div class="card-header border-bottom">
        <h5 class="card-title">Фильтр</h5>
    </div>

    <div class="card-body">
        <p class="text-muted m-b-30 font-12">Всего найдено элементов: <?php echo $filter['count']; ?></p>

        <form action="/control/servers/search" method="get">
            <div class="row">

                <div class="col-md-3">
                    <div class="form-group">
                        <label>Адрес сервера</label>
                        <input type="text" name="address" class="form-control input-sm" value="<?php echo $filter['address']; ?>">
                    </div>
                </div>

                <div class="col-md-3">
                    <div class="form-group">
                        <label>Статус</label>
                        <select name="status" class="form-control input-sm">
                            <option value="">--Не выбрана--</option>
                            <option value="1" <?php if ($filter['status'] === 1): ?>selected<?php endif; ?>>
                                Одобренные
                            </option>
                            <option value="0" <?php if ($filter['status'] === 1): ?>selected<?php endif; ?>>Ожидает модерации</option>
                        </select>
                    </div>
                </div>

            </div>


            <button type="submit" class="btn btn-primary waves-effect waves-light btn-sm">
                Найти
            </button>


        </form>
    </div>

</div>


<div class="card p-0">
    <div class="card-header border-bottom">
        <h5 class="card-title">Сервера</h5>
    </div>

    <div class="card-body">
        <h4 class="m-t-0 header-title"><b>Серверы</b></h4>
        <p class="text-muted m-b-30 font-12">Список по умолчанию сортируется по дате добавления</p>


        <table class="table table-bordered border text-nowrap text-md-nowrap">
            <thead>
            <tr>
                <th scope="col">#</th>
                <th scope="col">Игра</th>
                <th scope="col">Название</th>
                <th scope="col">Адрес</th>
                <th scope="col">Дата добавления</th>
                <th scope="col"></th>
            </tr>
            </thead>
            <tbody>
            <?php foreach ($servers as $row): ?>
                <tr id="server<?php echo $row['id']; ?>">
                    <td><?php echo $row['id']; ?></td>
                    <td>
                        <?php widgets\server\game\GameIcon::run($row['game']); ?>
                    </td>
                    <td>
                        <a href="/server/<?php echo $row['ip']; ?>:<?php echo $row['port']; ?>/info"><?php echo $row['hostname']; ?></a>
                    </td>
                    <td>

                         <span class="badge bg-dark">
                       <?php echo $row['ip']; ?>:<?php echo $row['port']; ?>
                        </span>


                    </td>
                    <td>
                        <span class="badge bg-dark my-1">
                            <?php echo date("d.m.Y [H:i]", $row['date_add']); ?>
                        </span>

                    </td>


                    <td>
                        <a href="/control/servers/edit?id=<?= $row['id']; ?>" class="text-muted"
                           title="Изменить сервер"><i class="fa fa-pencil"></i></a>
                        <a href="#" onclick="remove(<?= $row['id']; ?>); return false;" class="text-muted"
                           title="Удалить сервер"><i class="fa fa-trash"></i></a>

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

<script>
    function remove(id) {
        if (confirm("Вы действительно хотите удалить?")) {
            $.ajax({
                url: "/control/servers/remove",
                data: {'id': id},
                success: function () {
                    $('#server' + id + '').hide(300);
                }
            });
        }
    }
</script>