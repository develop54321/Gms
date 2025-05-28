<div class="page-header">
    <div>
        <h1 class="page-title">Услуги</h1>
    </div>
    <div class="ms-auto pageheader-btn">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="/control">Главная</a></li>
            <li class="breadcrumb-item active" aria-current="page">Услуги</li>
        </ol>
    </div>
</div>


<div class="card p-0">
    <div class="card-header border-bottom">
        <h5 class="card-title">Услуги</h5>
    </div>

    <div class="card-body">

        <a href="/control/services/add" class="btn btn-primary mb-3">Добавить новую услугу</a>


        <table class="table table-bordered border text-nowrap text-md-nowrap">
            <thead>
            <tr>
                <th>#</th>
                <th>Название</th>
                <th>Тип</th>
                <th>Период/значение</th>
                <th></th>
            </tr>
            </thead>

            <tbody>
            <?php foreach ($services as $row): ?>
                <tr id="element<?= $row['id']; ?>">
                    <td><?php echo $row['id']; ?></td>
                    <td><?php echo $row['name']; ?></td>
                    <td><?php if ($row['type'] == 'befirst'): ?>Befirst<?php elseif ($row['type'] == 'top'): ?>TOP<?php elseif ($row['type'] == 'vip'): ?>VIP<?php elseif ($row['type'] == 'color'): ?>Выделение цветом<?php elseif ($row['type'] == 'boost'): ?>Буст<?php elseif ($row['type'] == 'gamemenu'): ?>Gamemenu<?php elseif ($row['type'] == 'votes'): ?>Голоса<?php elseif ($row['type'] == 'razz'): ?>Разбан<?php endif; ?></td>
                    <td><?php echo $row['period']; ?></td>
                    <td>
                        <a href="/control/services/edit?id=<?= $row['id']; ?>" class="text-muted"
                           title="Изменить услугу"><i class="fa fa-pencil"></i></a>

                        <a href="#" onclick="remove(<?php echo $row['id']; ?>); return false;" class="text-muted"
                           title="Удалить услугу"><i class="fa fa-trash"></i></a>
                    </td>
                </tr>
            <?php endforeach; ?>
            </tbody>
        </table>

    </div>
</div>
<script>
    function remove(id) {
        if (confirm("Вы действительно хотите удалить?")) {
            $.ajax({
                url: "/control/services/remove",
                data: {'id': id},
                success: function (data) {
                    setTimeout(location.reload(), 2500);
                }
            });
        }
    }
</script>