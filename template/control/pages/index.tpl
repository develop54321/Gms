<div class="page-header">
    <div>
        <h1 class="page-title">Страницы</h1>
    </div>
    <div class="ms-auto pageheader-btn">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="/control">Главная</a></li>
            <li class="breadcrumb-item active" aria-current="page">Страницы</li>
        </ol>
    </div>
</div>


<div class="card p-0">
    <div class="card-header border-bottom">
        <h5 class="card-title">Страницы</h5>
    </div>

    <div class="card-body">
        <h4 class="m-t-0 header-title"><b>Страницы</b></h4>
        <p class="text-muted m-b-30 font-12">Список по умолчанию сортируется по дате добавления</p>


        <a href="/control/pages/add" class="btn btn-primary mb-3">Добавить новую страницу</a>


        <table class="table table-bordered border text-nowrap text-md-nowrap">
            <thead>
            <tr>
                <th scope="col">#</th>
                <th scope="col">Заголовок</th>
                <th scope="col">Количество посещений</th>
                <th scope="col">Дата добавления</th>

                <th scope="col"></th>
            </tr>
            </thead>
            <tbody>
            <?php foreach ($comments as $row): ?>

                <tr id="server<?php echo $row['id']; ?>">
                    <td><?php echo $row['id']; ?></td>

                    <td>
                        <a style="white-space: nowrap;overflow: hidden;text-overflow: ellipsis;display: block;width: 500px;"
                           href="/page/<?php echo $row['id']; ?>" target="_blank"><?php echo $row['title']; ?></a></td>

                    <td>
                        <?php echo $row['count_visited']; ?>
                    </td>
                    <td>
                        <?php echo date("d.m.Y [H:i]", $row['date_create']); ?>
                    </td>


                    <td>

                        <a href="/control/pages/edit?id=<?= $row['id']; ?>" class="text-muted"
                           title="Изменить страницу"><i class="fa fa-pencil"></i></a>
                        <a href="#" onclick="remove(<?= $row['id']; ?>); return false;" class="text-muted"
                           title="Удалить страницу"><i class="fa fa-trash"></i></a>

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
                url: "/control/pages/remove",
                data: {'id': id},
                success: function () {
                    $('#server' + id + '').hide(300);
                }
            });
        }
    }
</script>