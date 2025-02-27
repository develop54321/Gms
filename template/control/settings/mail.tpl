<div class="row">
    <div class="col-sm-12">
        <h4 class="page-title">Настройки</h4>
        <ol class="breadcrumb">
            <li><a href="/control">Главная</a></li>
            <li class="active">Настройки</li>
        </ol>
    </div>
</div>
<div class="col-sm-12">
    <div class="card-box">
        <h4 class="m-t-0 header-title"><b>Настройки</b></h4>


        <form id="settingsMailForm" method="post">
            <div class="row">
                <div class="col-md-6">
                    <div class="form-group">
                        <label>Метод отправки писем</label>
                        <select name="mail_params[type]" class="form-control">
                            <option value="mail">php mail</option>
                            <option value="smtp">smtp(рекомендуемый)</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label>Имя(отправителя)</label>
                        <input type="text" name="mail_params[from]" class="form-control" value="">
                    </div>
                </div>

                <div class="col-md-6">
                    <div class="form-group">
                        <label>SMTP сервер</label>
                        <input type="text" name="mail_params[smtp_server]" class="form-control" value="">
                    </div>

                    <div class="form-group">
                        <label>SMTP порт</label>
                        <input type="number" name="mail_params[smtp_port]" class="form-control" value="">
                    </div>

                    <div class="form-group">
                        <label>Шифрование</label>
                        <select name="mail_params[encrypt]" class="form-control">
                            <option value="none">Нет</option>
                            <option value="ssl">SSL</option>
                            <option value="tls">TLS</option>
                        </select>
                        <span> Для большинство серверов рекомендуется TLS. Если SMTP-провайдер поддерживает и то и другое, мы рекдомендуем использовать TLS.</span>
                    </div>

                    <div class="form-group">
                        <label>Имя пользователя SMTP</label>
                        <input type="text" name="mail_params[smtp_username]" class="form-control" value="">
                    </div>

                    <div class="form-group">
                        <label>Пароль SMTP</label>
                        <input type="text" name="mail_params[smtp_password]" class="form-control" value="">
                    </div>

                    <div class="form-group">
                        <label>Auto tls</label>
                        <input type="text" name="mail_params[auto_tls]" class="form-control" value="">
                    </div>
                </div>
            </div>



            <hr/>



            <hr/>


            <div class="form-group">
                <button type="submit" class="btn btn-primary text-uppercase waves-effect waves-light">
                    Сохранить
                </button>
            </div>
        </form>
    </div>

</div>

<script>
    $('#settingsMailForm').ajaxForm({
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