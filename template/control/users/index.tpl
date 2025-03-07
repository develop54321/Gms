<div class="page-header">
    <div>
        <h1 class="page-title">Пользователи</h1>
    </div>
    <div class="ms-auto pageheader-btn">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="/control">Главная</a></li>
            <li class="breadcrumb-item active" aria-current="page">Пользователи</li>
        </ol>
    </div>
</div>


<div class="card p-0">
    <div class="card-header border-bottom">
        <h5 class="card-title">Фильтр</h5>
    </div>

    <div class="card-body">

        <form action="/control/users/search" method="post">
            <div class="row">

                <div class="col-md-3">
                    <div class="form-group">
                        <label>Email</label>
                        <input type="email" name="query" class="form-control input-sm" required="">
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
        <h5 class="card-title">Пользователи</h5>
    </div>

    <div class="card-body">
        <h6 class="card-subtitle mb-2 text-muted">
            Пользователи по умолчанию сортируется по дате регистрации
        </h6>
        <hr/>
        <table class="table table-bordered border text-nowrap text-md-nowrap">
            <thead>
            <tr>
                <th scope="col">#</th>
                <th scope="col">Имя</th>
                <th scope="col">Email</th>
                <th scope="col">Роль</th>
                <th scope="col">Баланс</th>
                <th scope="col">Дата добавления</th>
                <th scope="col"></th>
            </tr>
            </thead>
            <tbody>
            <?php foreach ($users as $row): ?>
                <tr id="user<?php echo $row['id']; ?>">
                    <td><?php echo $row['id']; ?></td>
                    <td>
                        <?php echo $row['firstname']; ?><?php echo $row['lastname']; ?>
                    </td>
                    <td><?php echo $row['email']; ?></td>
                    <td><?php if ($row['role'] == 'admin'): ?>
                            <span class="badge bg-dark my-1">Администратор</span>
                        <?php elseif ($row['role'] == 'user'): ?>
                            <span class="badge bg-dark my-1">Пользователь</span>
                        <?php elseif ($row['role'] == 'partner'): ?>
                            <span class="badge bg-dark my-1">Партнер</span>
                        <?php endif; ?>
                    </td>
                    <td><?php echo \widgets\money\Money::run($row['balance']); ?></td>
                    <td>
                        <?php echo date("d:m:Y [H:i]", $row['date_reg']); ?>
                    </td>


                    <td>
                        <a href="/control/users/edit?id=<?= $row['id']; ?>" class="text-muted"
                           title="Изменить пользователя"><i class="fa fa-pencil"></i></a>
                        <a href="#" onclick="remove(<?= $row['id']; ?>); return false;" class="text-muted"
                           title="Удалить пользователя"><i class="fa fa-trash"></i></a>

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
                url: "/control/users/remove",
                data: {'id': id},
                success: function () {
                    $('#user' + id + '').hide(300);
                }
            });
        }
    }
</script>