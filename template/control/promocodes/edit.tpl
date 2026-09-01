<div class="page-header">
    <div>
        <h1 class="page-title">Изменение промокода</h1>
    </div>
    <div class="ms-auto pageheader-btn">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="/control">Главная</a></li>
            <li class="breadcrumb-item"><a href="/control/promocodes">Промокоды</a></li>
            <li class="breadcrumb-item active" aria-current="page">Изменение промокода</li>
        </ol>
    </div>
</div>

<div class="card p-0">
    <div class="card-header border-bottom">
        <h5 class="card-title">Изменение промокода <code><?php echo $data['code']; ?></code></h5>
    </div>

    <div class="card-body">

        <form action="#" id="promoForm" method="post">
            <div class="form-group">
                <label>Код промокода</label>
                <input type="text" class="form-control" value="<?php echo $data['code']; ?>" disabled>
            </div>

            <div class="form-group">
                <label for="amount">Сумма начисления (руб.)</label>
                <input type="number" name="amount" class="form-control" id="amount" min="1" value="<?php echo $data['amount']; ?>">
            </div>

            <div class="form-group">
                <label for="maxActivations">Лимит активаций (оставьте пустым для безлимита)</label>
                <input type="number" name="maxActivations" class="form-control" id="maxActivations" min="1" value="<?php echo $data['max_activations']; ?>">
            </div>

            <div class="form-group">
                <label for="status">Статус</label>
                <select name="status" class="form-control" id="status">
                    <option value="1" <?php if ($data['status'] == 1) echo 'selected'; ?>>Активен</option>
                    <option value="0" <?php if ($data['status'] == 0) echo 'selected'; ?>>Отключен</option>
                </select>
            </div>

            <div class="form-group">
                <label for="comment">Комментарий</label>
                <input type="text" name="comment" class="form-control" id="comment" value="<?php echo htmlspecialchars($data['comment'] ?? ''); ?>">
            </div>

            <p class="text-muted">
                Истекает: <?php echo $data['expires_at'] !== null ? date("d.m.Y", $data['expires_at']) : 'бессрочно'; ?>
                &nbsp;·&nbsp;
                Активировано: <?php echo $data['activations_count']; ?> раз
            </p>

            <div class="form-group text-right m-b-0">
                <button class="btn btn-primary waves-effect waves-light" type="submit">
                    Сохранить
                </button>
            </div>

        </form>

    </div>

</div>
<script>
    $('#promoForm').ajaxForm({
        dataType: 'json',
        success: function (data) {
            switch (data.status) {
                case "error":
                    ShowModal(data.error, 'answer', 'error');
                    break;

                case "success":
                    ShowModal(data.success, 'answer', 'success');
                    break;
            }
        },
    });
</script>
