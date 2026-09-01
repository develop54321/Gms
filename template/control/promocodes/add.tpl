<div class="page-header">
    <div>
        <h1 class="page-title">Добавление промокода</h1>
    </div>
    <div class="ms-auto pageheader-btn">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="/control">Главная</a></li>
            <li class="breadcrumb-item"><a href="/control/promocodes">Промокоды</a></li>
            <li class="breadcrumb-item active" aria-current="page">Добавление промокода</li>
        </ol>
    </div>
</div>

<div class="card p-0">
    <div class="card-header border-bottom">
        <h5 class="card-title">Добавление промокода</h5>
    </div>

    <div class="card-body">

        <form action="#" id="promoForm" method="post">
            <div class="form-group">
                <label for="code">Код промокода</label>
                <div class="input-group">
                    <input type="text" name="code" class="form-control text-uppercase" id="code" required>
                    <button class="btn btn-outline-secondary" type="button" onclick="generateCode()">Сгенерировать</button>
                </div>
            </div>

            <div class="form-group">
                <label for="amount">Сумма начисления (руб.)</label>
                <input type="number" name="amount" class="form-control" id="amount" min="1" required>
            </div>

            <div class="form-group">
                <label for="maxActivations">Лимит активаций (оставьте пустым для безлимита)</label>
                <input type="number" name="maxActivations" class="form-control" id="maxActivations" min="1">
            </div>

            <div class="form-group">
                <label for="period">Срок действия, в днях (оставьте пустым для бессрочного)</label>
                <input type="number" name="period" class="form-control" id="period" min="1">
            </div>

            <div class="form-group">
                <label for="comment">Комментарий (для админа, пользователю не виден)</label>
                <input type="text" name="comment" class="form-control" id="comment">
            </div>

            <div class="form-group text-right m-b-0">
                <button class="btn btn-primary waves-effect waves-light" type="submit">
                    Добавить
                </button>
            </div>

        </form>

    </div>

</div>
<script>
    function generateCode() {
        const chars = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789';
        let code = '';
        for (let i = 0; i < 10; i++) {
            code += chars[Math.floor(Math.random() * chars.length)];
        }
        document.getElementById('code').value = code;
    }

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
