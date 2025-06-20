<div class="page-header">
    <div>
        <h1 class="page-title">Цвета</h1>
    </div>
    <div class="ms-auto pageheader-btn">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="/control">Главная</a></li>
            <li class="breadcrumb-item active" aria-current="page">Цвета</li>
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

        <a href="/control/codecolors/add" class="btn btn-primary mb-3">Добавить новый цвет</a>

        <table class="table table-bordered border text-nowrap text-md-nowrap">
            <thead>
            <tr>
                <th scope="col">#</th>
                <th scope="col">Цвет</th>
                <th scope="col">Название</th>
                <th scope="col">HTML Код</th>
                <th scope="col">Активность</th>
                <th scope="col"></th>
            </tr>
            </thead>
            <tbody>
            <?php foreach ($CodeColors as $row): ?>
                <tr id="server<?php echo $row['id']; ?>">
                    <td><?php echo $row['id']; ?>
                        <input type="hidden" name="id[]" value="<?php echo $row['id']; ?>">
                    </td>
                    <td>
                        <div style="width: 40px; height: 20px; background: <?php echo $row['code']; ?>; border: 1px solid #ddd;"></div>
                    </td>
                    <td><?php echo $row['name']; ?></td>
                    <td><?php echo $row['code']; ?></td>
                    <td>
                        <?php if ($row['activ'] == 1): ?>Активен<?php elseif ($row['activ'] == 0): ?>Не активен<?php endif; ?>
                    </td>
                    <td>
                        <a href="/control/codecolors/edit?id=<?= $row['id']; ?>" class="text-muted"
                           title="Изменить комментария"><i class="fa fa-pencil"></i></a>
                        <a href="#" onclick="remove(<?= $row['id']; ?>); return false;" class="text-muted"
                           title="Удалить комментария"><i class="fa fa-trash"></i></a>
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
                url: "/control/codecolors/remove",
                data: {'id': id},
                success: function () {
                    $('#server' + id + '').hide(300);
                }
            });
        }
    }
</script>
