<div class="page-header">
    <div>
        <h1 class="page-title">Способы оплат</h1>
    </div>
    <div class="ms-auto pageheader-btn">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="/control">Главная</a></li>
            <li class="breadcrumb-item active" aria-current="page">Способы оплат</li>
        </ol>
    </div>
</div>


<div class="card p-0">
    <div class="card-header border-bottom">
        <h5 class="card-title">Способы оплат</h5>
    </div>

    <div class="card-body">

        <a href="/control/paymethods/add" class="btn btn-primary mb-3">Добавить новый способ</a>

        <table class="table table-bordered border text-nowrap text-md-nowrap">
            <thead>
            <tr>
                <th>#</th>
                <th>Шлюз</th>
                <th>Статус</th>
                <th></th>
            </tr>
            </thead>

            <tbody>
            <?php foreach ($paymethods as $row): ?>
                <tr id="services<?= $row['id']; ?>">
                    <td><?= $row['id']; ?></td>
                    <td><?= $row['name']; ?></td>
                    <td>Активно</td>
                    <td style="text-align: right;">
                        <a href="/control/paymethods/edit?id=<?php echo $row['id']; ?>" class="text-muted"
                           title="Изменить платежную систему"><i class="fa fa-pencil"></i></a>
                        <a href="#" onclick="remove(<?php echo $row['id']; ?>); return false;" class="text-muted"
                           title="Удалить платежную систему"><i class="fa fa-trash"></i></a>

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
                url: "/control/paymethods/remove",
                data: {'id': id},
                success: function () {
                    $('#services' + id + '').hide(300);
                }
            });
        }
    }
</script>