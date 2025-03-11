<div class="row">
    <div class="col-sm-12">
        <h4 class="page-title">Страницы</h4>
        <ol class="breadcrumb">
            <li><a href="/control">Главная</a></li>
            <li class="active">Страницы</li>
        </ol>
    </div>
</div>


<div class="col-sm-12">

    <div class="card-box">
        <h4 class="m-t-0 header-title"><b>Страницы</b></h4>
        <p class="text-muted m-b-30 font-12">Страницы по умолчанию сортируется по дате</p>
        <a href="/control/pages/add" style="float: right;"
           class="btn btn-inverse btn-custom btn-rounded waves-effect waves-light btn-xs">Добавить новую страницу</a>


        <table class="table table table-hover m-0">
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