<div class="row">
    <div class="col-sm-12">
        <h4 class="page-title">Тестирование почты</h4>
        <ol class="breadcrumb">
            <li><a href="/control">Главная</a></li>
            <li><a href="/control/settings">Настройки почты</a></li>
            <li class="active">Тестирование почты</li>
        </ol>
    </div>
</div>
<div class="col-sm-12">
    <div class="card-box">
        <h4 class="m-t-0 header-title"><b>Тестирование почты</b></h4>

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