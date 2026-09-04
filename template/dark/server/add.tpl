<section class="page add-server">
    <div class="container">
        <div class="add-server-head">
            <div class="icon"><i class="fa fa-plus"></i></div>
            <div>
                <h1>Добавить сервер</h1>
                <p>Четыре шага — и сервер отправится на проверку модератору</p>
            </div>
        </div>

        <form id="addServer" method="post">
            <div class="asv2-card">

                <div class="asv2-step">
                    <div class="asv2-num">1</div>
                    <div class="asv2-body">
                        <div class="step-title">Игра</div>
                        <div class="mb-3">
                            <div class="input-group">
                                <span class="input-group-text"><i class="fa fa-gamepad"></i></span>
                                <select class="form-control" name="game" required>
                                    <option disabled>Выберите игру</option>
                                    <?php foreach ($games as $row): ?>
                                        <option value="<?php echo $row['code']; ?>"><?php echo $row['game']; ?></option>
                                    <?php endforeach; ?>
                                </select>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="asv2-step">
                    <div class="asv2-num">2</div>
                    <div class="asv2-body">
                        <div class="step-title">Адрес сервера</div>
                        <div class="row g-2">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="ip">Адрес</label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="fa fa-globe"></i></span>
                                        <input type="text" class="form-control" name="ip" id="ip" placeholder="127.0.0.1">
                                    </div>
                                </div>
                            </div>
                            <div class="col-6 col-md-3">
                                <div class="mb-3">
                                    <label for="port">Порт</label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="fa fa-plug"></i></span>
                                        <input type="text" class="form-control" name="port" id="port" placeholder="27015">
                                    </div>
                                </div>
                            </div>
                            <div class="col-6 col-md-3">
                                <div class="mb-3">
                                    <label for="query_port">Query port</label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="fa fa-exchange"></i></span>
                                        <input type="text" class="form-control" name="query_port" id="query_port" placeholder="27015">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="asv2-step">
                    <div class="asv2-num">3</div>
                    <div class="asv2-body">
                        <div class="step-title">Описание</div>
                        <div class="mb-3">
                            <textarea class="form-control" name="text" placeholder="Коротко расскажите о сервере: режим, особенности, правила..." rows="3"></textarea>
                        </div>
                    </div>
                </div>

                <div class="asv2-step">
                    <div class="asv2-num">4</div>
                    <div class="asv2-body">
                        <div class="step-title">Подтверждение</div>
                        <div class="mb-3 d-flex flex-wrap align-items-start gap-3">
                            <a href="#" id="captchaImg" class="captcha-box" onclick="updateCaptcha(); return false;"></a>
                            <div style="flex:1;min-width:160px;">
                                <input type="text" name="captcha" class="form-control" id="captcha" required="" placeholder="Цифры с картинки"/>
                                <div class="captcha-hint"><i class="fa fa-refresh"></i> Не видно цифр? Нажмите на картинку.</div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="asv2-actions">
                    <button class="btn btn-primary" type="submit"><i class="fa fa-paper-plane"></i> Отправить на проверку</button>
                    <button class="btn btn-outline-secondary" type="reset" title="Сбросить форму">
                        <i class="fa fa-eraser"></i> Сбросить
                    </button>
                </div>
            </div>
        </form>

        <details class="rules-accordion">
            <summary>
                <i class="fa fa-exclamation-triangle"></i> Требования к серверу перед добавлением
                <span class="chev"><i class="fa fa-chevron-down"></i></span>
            </summary>
            <div class="rules-accordion-body">
                <ul class="rules-list">
                    <li><i class="fa fa-check-circle"></i> Работать 24/7.</li>
                    <li><i class="fa fa-check-circle"></i> Иметь более по одному администратору на каждые 5 слотов сервера.</li>
                    <li><i class="fa fa-check-circle"></i> Не загружать в клиент игры файлы форматов «.exe .cmd .jar .vbs .bat .com .dll» и подобного рода.</li>
                    <li><i class="fa fa-check-circle"></i> Запрещено прописывать игрокам автоматическое соединение с сервером.</li>
                    <li><i class="fa fa-check-circle"></i> Запрещён автоматический переход игроков на другие сервера.</li>
                    <li><i class="fa fa-check-circle"></i> Запрещено изменять «userconfig.cfg», «autoexec.cfg».</li>
                    <li><i class="fa fa-check-circle"></i> Запрещено редактировать более трех пунктов меню игры (game menu) у пользователей.</li>
                    <li><i class="fa fa-check-circle"></i> Не рекомендуется изменять «config.cfg» (кроме дополнительных клавиш для игры).</li>
                    <li><i class="fa fa-check-circle"></i> Запрещено использование команды ostrog.</li>
                </ul>

                <div class="rules-note">
                    <i class="fa fa-ban"></i>
                    При невыполнении одного или более правил, сервер не будет отображаться в мониторинге.
                </div>
            </div>
        </details>

    </div>
</section>

<script>
    function updateCaptcha() {
        $("#captchaImg").html('<img src="/captcha?form=add_server" src="Капча"/>');
    }

    updateCaptcha()

    $('#addServer').ajaxForm({
        dataType: 'json',
        success: function (data) {
            switch (data.status) {
                case "error":
                    updateCaptcha()
                    ShowModal(data.error, 'answer', 'error');
                    break;

                case "success":
                    ShowModal(data.success, 'answer', 'success');
                    break;
            }
        },
    });
</script>
