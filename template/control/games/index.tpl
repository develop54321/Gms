<div class="page-header">
    <div>
        <h1 class="page-title">Игры</h1>
    </div>
    <div class="ms-auto pageheader-btn">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="/control">Главная</a></li>
            <li class="breadcrumb-item active" aria-current="page">Игры</li>
        </ol>
    </div>
</div>

<div class="card p-0">
    <div class="card-header border-bottom">
        <h5 class="card-title">Игры</h5>
    </div>

    <div class="card-body">

        <a href="/control/games/add" class="btn btn-primary mb-3">Добавить новую игру</a>


        <table class="table table-bordered border text-nowrap text-md-nowrap">
            <thead>
            <tr>
                <th>#</th>
                <th>Название</th>
                <th>Статус</th>
                <th></th>
            </tr>
            </thead>

            <tbody>
            <?php foreach ($games as $row): ?>
                <tr id="game<?= $row['id']; ?>">
                    <td><?= $row['id']; ?></td>
                    <td><?= $row['game']; ?></td>
                    <td>
                        <span class="badge bg-dark my-1">Активно</span>
                    </td>
                    <td style="text-align: right;">
                        <a href="#" onclick="remove(<?= $row['id']; ?>); return false;" class="text-muted"
                           title="Удалить игру"><i class="fa fa-trash"></i></a>

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
                url: "/control/games/remove",
                data: {'id': id},
                success: function (data) {
                    $('#game' + id + '').hide(300);
                }
            });
        }
    }
</script>