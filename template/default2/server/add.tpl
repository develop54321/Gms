<section class="page add-server">
    <div class="container">
        <h1 class="content-title">
            Добавить сервер
        </h1>
        <hr/>


        <div class="section-add-server">
            <div class="row">
                <div class="col-md-4">
                    <form id="addServer" method="post">

                        <div class="form-group mb-3">
                            <div class="input-group mb-3">
                                <span class="input-group-text" id="basic-addon1"><i class="fa fa-gamepad"></i> </span>
                                <select class="form-control" name="game" required>
                                    <option disabled>Выберите игру</option>
                                    <?php foreach ($games as $row): ?>
                                        <option value="<?php echo $row['code']; ?>"><?php echo $row['game']; ?></option>
                                    <?php endforeach; ?>
                                </select>
                            </div>
                        </div>

                        <div class="form-group mb-3">
                            <input type="text" class="form-control" name="ip" id="formGroupExampleInput"
                                   placeholder="Адрес">
                        </div>


                        <div class="form-group mb-3">
                            <input type="text" class="form-control" name="port" id="formGroupExampleInput2"
                                   placeholder="Порт">
                        </div>


                        <div class="form-group mb-3">
                            <textarea class="form-control" name="text" placeholder="Описание"></textarea>

                        </div>

                        <div class="form-group mb-3">
                            <a href="#" id="captchaImg" onclick="updateCaptcha(); return false;">
                                <img src="/captcha" src="Капча"/>
                            </a>
                        </div>

                        <div class="form-group mb-3">
                            <input type="text" name="captcha" class="form-control" id="captcha" required="" placeholder="Цифры с картинки"/>
                            <small class="form-text text-muted">Если цифры не видны, обновите изображение, нажав на него.</small>
                        </div>

                        <div class="form-group mt-2">
                            <button class="btn btn-primary" type="submit">Отправить</button>
                            <button class="btn btn-outline-secondary" type="reset" title="Сбросить форму">
                                <i class="fa fa-eraser"></i>
                            </button>
                        </div>

                    </form>
                </div>

                <div class="col-md-8">

                    <div class="alert alert-warning">
                        <div><p><strong>Для добавления сервера в мониторинг, он должен удовлетворять следующим
                                    правилам:</strong></p>
                            <ul>
                                <li>Работать 24/7.</li>
                                <li>Иметь более по одному администратору на каждые 5 слотов сервера.</li>
                                <li>Не загружать в клиент игры файлы форматов «.exe .cmd .jar .vbs .bat .com .dll» и
                                    подобного рода.
                                </li>
                                <li>Запрещено прописывать игрокам автоматическое соединение с сервером.&nbsp;</li>
                                <li>Запрещён автоматический переход игроков на другие сервера.</li>
                                <li><span style="line-height: 1.3em;">Запрещено изменять &nbsp;«userconfig.cfg», «autoexec.cfg».</span>
                                </li>
                                <li>Запрещено редактировать более трех пунктов меню игры (game menu) у пользователей.
                                </li>
                                <li>Не рекомендуется изменять «config.cfg» (кроме дополнительных клавиш для игры),</li>
                                <li> Запрещено использование команды ostrog</li>
                            </ul>
                            <p><strong>При невыполнении одного или более правил, сервер не будет отображаться в
                                    мониторинге.</strong></p>
                        </div>
                    </div>
                </div>

            </div>
        </div>


    </div>
</section>

<script>
    $('#addServer').ajaxForm({
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
