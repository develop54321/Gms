<div class="page-header">
    <div>
        <h1 class="page-title">Логи системные</h1>
    </div>
    <div class="ms-auto pageheader-btn">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="/control">Главная</a></li>
            <li class="breadcrumb-item active" aria-current="page">Логи системные</li>
        </ol>
    </div>
</div>

<div class="card p-0">
    <div class="card-header border-bottom">
        <h5 class="card-title">Игры</h5>
    </div>

    <div class="card-body">


        <?php if (count($data) > 1):?>
        <a href="/control/logs/clear" onclick="return confirm('Вы действительно хотите очистить логи?');"
           class="btn btn-danger mb-3"> <i class="fa fa-trash"></i> Очистить</a>
        <?php endif;?>

        <table class="table table-bordered border text-nowrap text-md-nowrap">
            <thead>
            <tr>
                <th scope="col">#</th>
                <th scope="col">Описание</th>
                <th scope="col">Дата инициализация</th>
            </tr>
            </thead>
            <tbody>
            <?php foreach ($data as $row): ?>

                <tr>
                    <td><?php echo $row['id']; ?></td>
                    <td><?php echo $row['text']; ?></td>
                    <td><?php echo date("d.m.Y [H:i]", $row['date_create']); ?></td>
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

