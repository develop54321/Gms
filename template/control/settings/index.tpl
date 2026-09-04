<div class="page-header mb-4">
    <div>
        <h1 class="page-title">Настройки</h1>
        <small class="text-muted">Глобальная конфигурация сайта</small>
    </div>
    <div class="ms-auto">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="/control">Главная</a></li>
            <li class="breadcrumb-item active">Настройки</li>
        </ol>
    </div>
</div>

<style>
    .setting-item {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 14px 20px;
        border-bottom: 1px solid #eee;
    }

    .setting-item span {
        font-weight: 500;
    }



    .form-switch .form-check-input {
        width: 42px;
        height: 22px;
        cursor: pointer;
    }
</style>

<form id="settingsForm" method="post" enctype="multipart/form-data">

    <!-- Основные настройки -->
    <div class="card mb-4">
        <div class="card-header border-bottom">
            <h5 class="card-title">Основные настройки</h5>
        </div>
        <div class="card-body">
            <div class="row">
                <div class="col-md-6">
                    <div class="form-group">
                        <label>Название сайта</label>
                        <input type="text" class="form-control"
                               name="global_settings[site_name]"
                               value="<?= $settings['global_settings']['site_name']; ?>">
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        <label>Срок истечения не оплаченных счетов (часы)</label>
                        <input type="number" class="form-control"
                               name="global_settings[expired_time_payment]"
                               value="<?= $settings['global_settings']['expired_time_payment']; ?>">
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Брендинг -->
    <div class="card mb-4">
        <div class="card-header border-bottom">
            <h5 class="card-title">Брендинг</h5>
        </div>
        <div class="card-body">
            <div class="form-group">
                <label>Описание сайта (meta description)</label>
                <textarea class="form-control" name="global_settings[site_description]" rows="2"><?= htmlspecialchars($settings['global_settings']['site_description'] ?? '') ?></textarea>
            </div>

            <div class="row">
                <div class="col-md-6">
                    <div class="form-group">
                        <label>Логотип</label>
                        <?php if (!empty($settings['global_settings']['logo_path'])): ?>
                            <div class="mb-2">
                                <img src="<?= $settings['global_settings']['logo_path'] ?>?v=<?= time() ?>" alt="Логотип"
                                     style="max-height:48px;max-width:220px;background:#0a0c12;border-radius:8px;padding:6px;">
                            </div>
                            <div class="form-check mb-2">
                                <input class="form-check-input" type="checkbox" name="global_settings[remove_logo]" value="1" id="removeLogo">
                                <label class="form-check-label" for="removeLogo">Удалить текущий логотип</label>
                            </div>
                        <?php endif; ?>
                        <input type="file" class="form-control" name="logo" accept="image/png,image/jpeg,image/gif,image/webp">
                        <small class="form-text text-muted">PNG/JPG/GIF/WEBP, до 2 МБ. Если не загружен — в шапке показывается иконка + название сайта.</small>
                    </div>
                </div>

                <div class="col-md-6">
                    <div class="form-group">
                        <label>Favicon</label>
                        <?php if (!empty($settings['global_settings']['favicon_path'])): ?>
                            <div class="mb-2">
                                <img src="<?= $settings['global_settings']['favicon_path'] ?>?v=<?= time() ?>" alt="Favicon"
                                     style="max-height:32px;max-width:32px;background:#0a0c12;border-radius:6px;padding:4px;">
                            </div>
                            <div class="form-check mb-2">
                                <input class="form-check-input" type="checkbox" name="global_settings[remove_favicon]" value="1" id="removeFavicon">
                                <label class="form-check-label" for="removeFavicon">Удалить текущий favicon</label>
                            </div>
                        <?php endif; ?>
                        <input type="file" class="form-control" name="favicon" accept="image/png,image/x-icon">
                        <small class="form-text text-muted">PNG/ICO, до 2 МБ. Если не загружен — используется стандартный favicon.</small>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Серверы -->
    <div class="card mb-4">
        <div class="card-header border-bottom">
            <h5 class="mb-0">Серверы и отображение</h5>
        </div>
        <div class="card-body">
            <div class="row">

                <div class="col-md-6">
                    <div class="form-group">
                        <label>Добавление сервера</label>
                        <select class="form-control" name="global_settings[auto_add_server]">
                            <option value="1">Автоматически</option>
                            <option value="0" <?= $settings['global_settings']['auto_add_server'] == 0 ? 'selected' : '' ?>>
                            Вручную (модерация)
                            </option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label>Серверов на главной странице</label>
                        <input type="number" class="form-control"
                               name="global_settings[count_servers_main]"
                               value="<?= $settings['global_settings']['count_servers_main']; ?>">
                    </div>
                </div>

                <div class="col-md-6">
                    <div class="form-group">
                        <label>Максимальное количество ТОП серверов</label>
                        <input type="number" class="form-control"
                               name="global_settings[count_servers_top]"
                               value="<?= $settings['global_settings']['count_servers_top']; ?>">
                    </div>

                    <div class="form-group">
                        <label>Максимальное количество ВИП серверов</label>
                        <input type="number" class="form-control"
                               name="global_settings[count_servers_vip]"
                               value="<?= $settings['global_settings']['count_servers_vip']; ?>">
                    </div>

                    <div class="form-group">
                        <label>Максимальное количество БУСТ серверов</label>
                        <input type="number" class="form-control"
                               name="global_settings[count_servers_boost]"
                               value="<?= $settings['global_settings']['count_servers_boost']; ?>">
                    </div>

                    <div class="form-group">
                        <label>Максимальное количество окрашенных (или помеченных цветом) серверов</label>
                        <input type="number" class="form-control"
                               name="global_settings[count_servers_color]"
                               value="<?= $settings['global_settings']['count_servers_color']; ?>">
                    </div>

                    <div class="form-group">
                        <label>Максимальное количество GameMenu серверов</label>
                        <input type="number" class="form-control"
                               name="global_settings[count_servers_gamemenu]"
                               value="<?= $settings['global_settings']['count_servers_gamemenu']; ?>">
                    </div>
                </div>

            </div>
        </div>
    </div>

    <!-- Платные функции -->
    <div class="card mb-4">
        <div class="card-header border-bottom">
            <h5 class="mb-0">Платные функции</h5>
        </div>
        <div class="card-body p-0">

            <div class="setting-item">
                <span>TOP</span>
                <input type="hidden" name="global_settings[top_on]" value="0">
                <div class="form-check form-switch">
                    <input class="form-check-input" type="checkbox"
                           name="global_settings[top_on]"
                           value="1" <?= $settings['global_settings']['top_on'] ? 'checked' : '' ?>>
                </div>
            </div>

            <div class="setting-item">
                <span>Буст</span>
                <input type="hidden" name="global_settings[boost_on]" value="0">
                <div class="form-check form-switch">
                    <input class="form-check-input" type="checkbox"
                           name="global_settings[boost_on]"
                           value="1" <?= $settings['global_settings']['boost_on'] ? 'checked' : '' ?>>
                </div>
            </div>

            <div class="setting-item">
                <span>VIP</span>
                <input type="hidden" name="global_settings[vip_on]" value="0">
                <div class="form-check form-switch">
                    <input class="form-check-input" type="checkbox"
                           name="global_settings[vip_on]"
                           value="1" <?= $settings['global_settings']['vip_on'] ? 'checked' : '' ?>>
                </div>
            </div>

            <div class="setting-item">
                <span>GameMenu</span>
                <input type="hidden" name="global_settings[gamemenu_on]" value="0">
                <div class="form-check form-switch">
                    <input class="form-check-input" type="checkbox"
                           name="global_settings[gamemenu_on]"
                           value="1" <?= $settings['global_settings']['gamemenu_on'] ? 'checked' : '' ?>>
                </div>
            </div>

            <div class="setting-item">
                <span>Выделение цветом</span>
                <input type="hidden" name="global_settings[color_on]" value="0">
                <div class="form-check form-switch">
                    <input class="form-check-input" type="checkbox"
                           name="global_settings[color_on]"
                           value="1" <?= $settings['global_settings']['color_on'] ? 'checked' : '' ?>>
                </div>
            </div>

            <div class="setting-item border-0">
                <span>Покупка голосов</span>
                <input type="hidden" name="global_settings[votes_on]" value="0">
                <div class="form-check form-switch">
                    <input class="form-check-input" type="checkbox"
                           name="global_settings[votes_on]"
                           value="1" <?= $settings['global_settings']['votes_on'] ? 'checked' : '' ?>>
                </div>
            </div>

        </div>
    </div>

    <!-- Комментарии -->
    <div class="card mb-4">
        <div class="card-header border-bottom">
            <h5 class="mb-0">Комментарии</h5>
        </div>
        <div class="card-body">
            <div class="row">

                <div class="col-md-6">
                    <div class="form-group">
                        <label>Гости могут писать комментарии</label>
                        <select class="form-control" name="comments[guest_allow]">
                            <option value="1">Да</option>
                            <option value="0" <?= $settings['comments']['guest_allow'] == 0 ? 'selected' : '' ?>>Нет</option>
                        </select>
                    </div>
                </div>

                <div class="col-md-6">
                    <div class="form-group">
                        <label>Модерация комментариев</label>
                        <select class="form-control" name="comments[moderation]">
                            <option value="1">Автоматически</option>
                            <option value="0" <?= $settings['comments']['moderation'] == 0 ? 'selected' : '' ?>>
                            Вручную
                            </option>
                        </select>
                    </div>
                </div>

            </div>
        </div>
    </div>

    <!-- Кнопка -->
    <div class="text-end">
        <button type="submit" class="btn btn-primary px-4 mb-3">
            💾 Сохранить настройки
        </button>
    </div>

</form>

<script>
    $('#settingsForm').ajaxForm({
        dataType: 'json',
        success: function (data) {
            if (data.status === 'error') {
                ShowModal(data.error, 'answer', 'error');
            }
            if (data.status === 'success') {
                ShowModal(data.success, 'answer', 'success');
            }
        }
    });
</script>
