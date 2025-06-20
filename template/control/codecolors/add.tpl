<div class="page-header">
    <div>
        <h1 class="page-title">Добавление страницы</h1>
    </div>
    <div class="ms-auto pageheader-btn">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="/control">Главная</a></li>
            <li class="breadcrumb-item"><a href="/control/codecolors">Цвета</a></li>
            <li class="breadcrumb-item active" aria-current="page">Добавление цвета</li>
        </ol>
    </div>
</div>


<div class="card p-0">
    <div class="card-header border-bottom">
        <h5 class="card-title">Добавление цвета</h5>
    </div>

    <div class="card-body">

        <form action="#" id="servicesForm" method="post">
            <div class="form-group">
                <label for="activ">Активность</label>
                <select name="activ" class="form-control" id="activ">
                    <option value="1">Активен</option>
                    <option value="0">Не активен</option>
                </select>
            </div>

            <div class="form-group">
                <label for="name">Название цвета</label>
                <input type="text" name="name" class="form-control" id="name">
            </div>

            <div class="form-group">
                <label for="code">Код цвета</label>
                <input type="text" name="code" class="form-control" id="code">
            </div>

            <div class="form-group text-right m-b-0">
                <button class="btn btn-primary waves-effect waves-light" type="submit">Добавить</button>
            </div>
        </form>
    </div>
</div>

<script>
    $('#servicesForm').ajaxForm({
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
