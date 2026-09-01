<div class="page-header">
    <div>
        <h1 class="page-title">Промокоды</h1>
    </div>
    <div class="ms-auto pageheader-btn">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="/control">Главная</a></li>
            <li class="breadcrumb-item active" aria-current="page">Промокоды</li>
        </ol>
    </div>
</div>


<div class="card p-0">
    <div class="card-header border-bottom">
        <h5 class="card-title">Промокоды</h5>
    </div>

    <div class="card-body">
        <a href="/control/promocodes/add" class="btn btn-primary mb-3">Добавить промокод</a>

        <table class="table table-bordered border text-nowrap text-md-nowrap">
            <thead>
            <tr>
                <th scope="col">#</th>
                <th scope="col">Код</th>
                <th scope="col">Сумма</th>
                <th scope="col">Активаций</th>
                <th scope="col">Истекает</th>
                <th scope="col">Статус</th>
                <th scope="col">Комментарий</th>
                <th scope="col"></th>
            </tr>
            </thead>
            <tbody>
            <?php foreach ($promoCodes as $row): ?>
                <tr id="promo<?php echo $row['id']; ?>">
                    <td><?php echo $row['id']; ?></td>
                    <td><code><?php echo $row['code']; ?></code></td>
                    <td><?php echo $row['amount']; ?> руб.</td>
                    <td>
                        <?php echo $row['activations_count']; ?><?php echo $row['max_activations'] !== null ? ' / ' . $row['max_activations'] : ''; ?>
                    </td>
                    <td>
                        <?php echo $row['expires_at'] !== null ? date("d.m.Y", $row['expires_at']) : 'Бессрочно'; ?>
                    </td>
                    <td>
                        <?php if ($row['status'] == 1): ?>
                            <span class="badge bg-success">Активен</span>
                        <?php else: ?>
                            <span class="badge bg-secondary">Отключен</span>
                        <?php endif; ?>
                    </td>
                    <td><?php echo $row['comment']; ?></td>
                    <td>
                        <a href="/control/promocodes/edit?id=<?= $row['id']; ?>" class="text-muted"
                           title="Изменить"><i class="fa fa-pencil"></i></a>
                        <a href="#" onclick="remove(<?= $row['id']; ?>); return false;" class="text-muted"
                           title="Удалить"><i class="fa fa-trash"></i></a>
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
                url: "/control/promocodes/remove",
                data: {'id': id},
                success: function () {
                    $('#promo' + id + '').hide(300);
                }
            });
        }
    }
</script>
