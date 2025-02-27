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

        <a href="/control/settings/mail/test" class="btn btn-warning btn-sm" style="margin-bottom: 20px;">Тестирование</a>

        <form id="settingsMailForm" method="post">
            <div class="row">
                <div class="col-md-6">
                    <div class="form-group">
                        <label>Метод отправки писем</label>
                        <select name="mail_params[type]" class="form-control">
                            <option value="mail">php mail</option>
                            <option value="smtp" <?php if ($settings['type'] === 'smtp'):?>selected<?php endif;?>>smtp(рекомендуемый)</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label>Имя(отправителя)</label>
                        <input type="text" name="mail_params[from]" class="form-control" value="<?php echo $settings['from'] ?? null; ?>">
                    </div>
                </div>

                <div class="col-md-6">
                    <div class="form-group">
                        <label>Сервер SMTP</label>
                        <input type="text" name="mail_params[smtp_server]" class="form-control" value="<?php echo $settings['smtp_server'] ?? null; ?>">
                    </div>

                    <div class="form-group">
                        <label>Порт SMTP</label>
                        <input type="number" name="mail_params[smtp_port]" class="form-control" value="<?php echo $settings['smtp_port'] ?? null; ?>">
                    </div>

                    <div class="form-group">
                        <label>Шифрование</label>
                        <select name="mail_params[encrypt]" class="form-control">
                            <option value="none">Нет</option>
                            <option value="ssl" <?php if ($settings['encrypt'] === 'ssl'):?>selected<?php endif;?>>SSL</option>
                            <option value="tls" <?php if ($settings['encrypt'] === 'tls'):?>selected<?php endif;?>>TLS</option>
                        </select>
                        <span> Для большинство серверов рекомендуется TLS. Если SMTP-провайдер поддерживает и то и другое, мы рекдомендуем использовать TLS.</span>
                    </div>

                    <div class="form-group">
                        <label>Имя пользователя SMTP</label>
                        <input type="text" name="mail_params[smtp_username]" class="form-control" value="<?php echo $settings['smtp_username'] ?? null; ?>">
                    </div>

                    <div class="form-group">
                        <label>Пароль SMTP</label>
                        <input type="text" name="mail_params[smtp_password]" class="form-control" value="<?php echo $settings['smtp_password'] ?? null; ?>">
                    </div>

                    <div class="form-group">
                        <div class="form-check">
                            <input type="checkbox" name="mail_params[auto_tls]" class="form-check-input" id="autoTls">
                            <label class="form-check-label" for="autoTls">Auto TLS</label>
                        </div>

                        <span>
                            Автоматически используется tls шифрование, если сервер поддерживает его.
                        </span>
                    </div>




                </div>
            </div>


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