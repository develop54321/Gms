<div class="page-header">
    <div>
        <h1 class="page-title">Изменение цвета</h1>
    </div>
    <div class="ms-auto pageheader-btn">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="/control">Главная</a></li>
            <li class="breadcrumb-item"><a href="/control/codecolors">Цвета</a></li>
            <li class="breadcrumb-item active" aria-current="page">Изменение цвета</li>
        </ol>
    </div>
</div>


<div class="card p-0">
    <div class="card-header border-bottom">
        <h5 class="card-title">Добавление цвета</h5>
    </div>

    <div class="card-body">
        <form action="#" id="codecolorsForm" method="post">


            <div class="form-group">
                <label for="moderation">Активность</label>
                <select name="activ" class="form-control" id="activ">
                    <option value="1">Активен</option>
                    <option value="0" <?php if ($data['activ'] == '0'): ?>selected<?php endif; ?>>Не активен</option>
                </select>
            </div>

            <div class="form-group">
                <label for="name">Цвет</label>
                <input type="int" name="name" class="form-control" value="<?= $data['name']; ?>"/>
            </div>

            <div class="form-group">
                <label for="code">HTML Код</label>
                <input type="int" name="code" class="form-control" value="<?= $data['code']; ?>"/>
            </div>

            <div class="form-group text-right m-b-0">
                <button class="btn btn-warning waves-effect waves-light" type="submit">
                    Изменить
                </button>
            </div>
        </form>
    </div>

</div>


<script>
    $('#codecolorsForm').ajaxForm({
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
