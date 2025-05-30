<div class="page-header">
    <div>
        <h1 class="page-title">Настройки</h1>
    </div>
    <div class="ms-auto pageheader-btn">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="/control">Главная</a></li>
            <li class="breadcrumb-item active" aria-current="page">Настройки</li>
        </ol>
    </div>
</div>

<div class="card p-0">
    <div class="card-header border-bottom">
        <h5 class="card-title">Настройки</h5>
    </div>

    <div class="card-body">

        <form id="settingsForm" method="post">
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Название сайта</label>
                                        <input type="text" name="global_settings[site_name]" class="form-control"
                                               value="<?= $settings['global_settings']['site_name']; ?>">
                                    </div>

                                    <div class="form-group">
                                        <label>Срок истечение не оплаченных счетов(в часах)</label>
                                        <input type="number" name="global_settings[expired_time_payment]"
                                               class="form-control"
                                               value="<?= $settings['global_settings']['expired_time_payment']; ?>">
                                    </div>

                                </div>

                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Добавление сервера</label>
                                        <select class="form-control" name="global_settings[auto_add_server]">
                                            <option value="1">Автоматически</option>
                                            <option value="0"
                                                    <?php if ($settings['global_settings']['auto_add_server'] == '0'): ?>selected=""<?php endif; ?>>
                                                Вручную(проверяется администраторм)
                                            </option>
                                        </select>
                                    </div>

                                    <div class="form-group">
                                        <label>Кол-во серверов на главной странице</label>
                                        <input type="number" name="global_settings[count_servers_main]"
                                               class="form-control"
                                               value="<?= $settings['global_settings']['count_servers_main']; ?>">
                                    </div>


                                </div>
                            </div>



                            <hr/>

                        <div class="row">
                            <div class="col-md-6">


                                <div class="form-group">
                                    <label>Кол-во серверов Top</label>
                                    <input type="int" name="global_settings[count_servers_top]" class="form-control"
                                           value="<?= $settings['global_settings']['count_servers_top']; ?>">
                                </div>

                                <div class="form-group">
                                    <label>Кол-во серверов Vip</label>
                                    <input type="int" name="global_settings[count_servers_vip]" class="form-control"
                                           value="<?= $settings['global_settings']['count_servers_vip']; ?>">
                                </div>

                                <div class="form-group">
                                    <label>Кол-во серверов Boost</label>
                                    <input type="int" name="global_settings[count_servers_boost]" class="form-control"
                                           value="<?= $settings['global_settings']['count_servers_boost']; ?>">
                                </div>

                                <div class="form-group">
                                    <label>Кол-во серверов Color</label>
                                    <input type="int" name="global_settings[count_servers_color]" class="form-control"
                                           value="<?= $settings['global_settings']['count_servers_color']; ?>">
                                </div>

                                <div class="form-group">
                                    <label>Кол-во серверов Gamemenu</label>
                                    <input type="int" name="global_settings[count_servers_gamemenu]"
                                           class="form-control"
                                           value="<?= $settings['global_settings']['count_servers_gamemenu']; ?>">
                                </div>

                            </div>


                            <div class="col-md-6">


                                <div class="form-group">
                                    <label>Вкл/Выкл Top</label>
                                    <input type="int" name="global_settings[top_on]" class="form-control"
                                           value="<?= $settings['global_settings']['top_on']; ?>">
                                </div>

                                <div class="form-group">
                                    <label>Вкл/Выкл Boost</label>
                                    <input type="int" name="global_settings[boost_on]" class="form-control"
                                           value="<?= $settings['global_settings']['boost_on']; ?>">
                                </div>

                                <div class="form-group">
                                    <label>Вкл/Выкл Vip</label>
                                    <input type="int" name="global_settings[vip_on]" class="form-control"
                                           value="<?= $settings['global_settings']['vip_on']; ?>">
                                </div>

                                <div class="form-group">
                                    <label>Вкл/Выкл Color</label>
                                    <input type="int" name="global_settings[color_on]" class="form-control"
                                           value="<?= $settings['global_settings']['color_on']; ?>">
                                </div>

                                <div class="form-group">
                                    <label>Вкл/Выкл Gamemenu</label>
                                    <input type="int" name="global_settings[gamemenu_on]" class="form-control"
                                           value="<?= $settings['global_settings']['gamemenu_on']; ?>">
                                </div>

                                <div class="form-group">
                                    <label>Вкл/Выкл Покупку голосов</label>
                                    <input type="int" name="global_settings[votes_on]" class="form-control"
                                           value="<?= $settings['global_settings']['votes_on']; ?>">
                                </div>

                            </div>
                        </div>


                            <hr/>
                        <div class="row">
                            <div class="col-md-6">

                                <div class="form-group">
                                    <label>Разрешить гостям оставлять комментарии</label>
                                    <select class="form-control" name="comments[guest_allow]">
                                        <option value="1">Да</option>
                                        <option value="0"
                                                <?php if ($settings['comments']['guest_allow'] == '0'): ?>selected=""<?php endif; ?>>
                                            Нет
                                        </option>
                                    </select>
                                </div>


                            </div>

                            <div class="col-md-6">
                                <div class="form-group">
                                    <label>Добавление комментарии</label>
                                    <select class="form-control" name="comments[moderation]">
                                        <option value="1">Автоматически</option>
                                        <option value="0"
                                                <?php if ($settings['comments']['moderation'] == '0'): ?>selected=""<?php endif; ?>>
                                            Вручную(проверяется администраторм)
                                        </option>
                                    </select>
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
    $('#settingsForm').ajaxForm({
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