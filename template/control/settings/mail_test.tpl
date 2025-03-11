<div class="page-header">
    <div>
        <h1 class="page-title">Тестирование почты</h1>
    </div>
    <div class="ms-auto pageheader-btn">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="/control">Главная</a></li>
            <li class="breadcrumb-item active" aria-current="page">Тестирование почты</li>
        </ol>
    </div>
</div>


<div class="card p-0">
    <div class="card-header border-bottom">
        <h5 class="card-title">Тестирование почты</h5>
    </div>

    <div class="card-body">

        <form id="settingsMailTestForm" method="post">
            <div class="row">
                <div class="col-md-12">
                    <div class="form-group">
                        <label>Адрес получателя</label>
                        <input type="text" name="mail_params[address]" class="form-control" value="">
                    </div>

                    <div class="form-group">
                        <label>Заголовок</label>
                        <input type="text" name="mail_params[subject]" class="form-control" value="">
                    </div>

                    <div class="form-group">
                        <label>Сообщение</label>
                        <textarea name="mail_params[message]" class="form-control"></textarea>
                    </div>
                </div>
            </div>


            <div class="form-group">
                <button type="submit" class="btn btn-primary">
                    Отправить
                </button>
            </div>
        </form>
    </div>

</div>

<script>
    $('#settingsMailTestForm').ajaxForm({
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

        error: function(xhr, status, error) {
            console.log(xhr.status);
            console.log(error);
        }
    });
</script>