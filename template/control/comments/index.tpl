<div class="page-header">
    <div>
        <h1 class="page-title">Комментарии</h1>
    </div>
    <div class="ms-auto pageheader-btn">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="/control">Главная</a></li>
            <li class="breadcrumb-item active" aria-current="page">Комментарии</li>
        </ol>
    </div>
</div>


<div class="card p-0">
    <div class="card-header border-bottom">
        <h5 class="card-title">Фильтр</h5>
    </div>

    <div class="card-body">
        <p class="text-muted m-b-30 font-12">Всего найдено элементов: <?php echo $filter['count']; ?></p>
        <form action="/control/comments/search" method="get">
            <div class="row">


                <div class="col-md-3">
                    <div class="form-group">
                        <label>Статус</label>
                        <select name="status" class="form-control input-sm">
                            <option value="">--Не выбрана--</option>
                            <option value="1" <?php if ($filter['status'] == '1'): ?>selected<?php endif; ?>>
                                Показывается
                            </option>
                            <option value="0" <?php if ($filter['status'] == '0'): ?>selected<?php endif; ?>>Ожидет
                                проверку
                            </option>
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
        <h5 class="card-title">Комментарии</h5>
    </div>

    <div class="card-body">
        <h4 class="m-t-0 header-title"><b>Комментарии</b></h4>
        <p class="text-muted m-b-30 font-12">Список по умолчанию сортируется по дате добавления</p>


        <table class="table table-bordered border text-nowrap text-md-nowrap">
            <thead>
            <tr>
                <th scope="col">#</th>
                <th scope="col">Текст</th>
                <th scope="col">Дата добавления</th>
                <th scope="col">Статус</th>
                <th scope="col"></th>
            </tr>
            </thead>
            <tbody>
            <?php foreach ($comments as $row): ?>

                <tr id="server<?php echo $row['id']; ?>">
                    <td><?php echo $row['id']; ?></td>

                    <td>
                        <a style="white-space: nowrap;overflow: hidden;text-overflow: ellipsis;display: block;width: 500px;"
                           target="_blank"
                           href="/server/<?php echo $row['ip']; ?>:<?php echo $row['port']; ?>/info"><?php echo $row['text']; ?></a>
                    </td>
                    <td>
                        <?php echo date("d.m.Y [H:i]", $row['date_create']); ?>
                    </td>


                    <td>
                        <?php if ($row['moderation'] == '0'): ?>
                            <label class="label label-warning">Ожидает проверки</label>
                        <?php elseif ($row['moderation'] == '1'): ?>
                            <label class="label label-success">Показывается</label>
                        <?php endif; ?>

                    </td>

                    <td>
                        <?php if ($row['moderation'] == '0'): ?>
                            <a href="/control/comments/moderation?id=<?= $row['id']; ?>" class="btn btn-success btn-xs"
                               title="Одобрить"><i class="fa fa-check"></i></a>
                        <?php endif; ?>

                        <a href="/control/comments/edit?id=<?= $row['id']; ?>" class="text-muted"
                           title="Изменить комментария"><i class="fa fa-pencil"></i></a>
                        <a href="#" onclick="remove(<?= $row['id']; ?>); return false;" class="text-muted"
                           title="Удалить комментария"><i class="fa fa-trash"></i></a>

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
                url: "/control/comments/remove",
                data: {'id': id},
                success: function () {
                    $('#server' + id + '').hide(300);
                }
            });
        }
    }
</script>