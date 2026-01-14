<div class="page-header">
    <div>
        <h1 class="page-title">Изменение сервера</h1>
    </div>
    <div class="ms-auto pageheader-btn">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="/control">Главная</a></li>
            <li class="breadcrumb-item"><a href="/control/servers">Сервера</a></li>
            <li class="breadcrumb-item active" aria-current="page">Изменение сервера</li>
        </ol>
    </div>
</div>

<!-- Основная информация -->
<div class="card p-0 mb-4">
    <div class="card-header border-bottom">
        <h5 class="card-title mb-0">Основная информация</h5>
    </div>

    <div class="card-body">
        <form action="#" id="serverMainForm" method="post">
            <div class="row">
                <div class="col-md-6 col-lg-6">
                    <div class="form-group mb-3">
                        <label for="status">Статус</label>
                        <select name="status" class="form-control" id="status">
                            <option value="1">Включено</option>
                            <option value="0" <?= $data['status'] == '0' ? 'selected' : ''; ?>>Отключено</option>
                        </select>
                    </div>

                    <div class="form-group mb-3">
                        <label for="moderation">Модерация</label>
                        <select name="moderation" class="form-control" id="moderation">
                            <option value="1">Показывается</option>
                            <option value="0" <?= $data['moderation'] == '0' ? 'selected' : ''; ?>>Отклонено</option>
                        </select>
                    </div>

                    <div class="form-group mb-3">
                        <label for="game">Игра</label>
                        <select name="game" class="form-control" id="game">
                            <?php foreach($games as $row): ?>
                            <option value="<?= $row['code']; ?>" <?= $data['game'] == $row['code'] ? 'selected' : ''; ?>>
                            <?= $row['game']; ?>
                            </option>
                            <?php endforeach; ?>
                        </select>
                    </div>


                </div>

                <div class="col-md-6 col-lg-6">
                    <div class="form-group mb-3">
                        <label for="ip">IP</label>
                        <input type="text" name="ip" class="form-control" id="ip" value="<?= $data['ip']; ?>">
                    </div>

                    <div class="form-group mb-3">
                        <label for="port">Порт</label>
                        <input type="text" name="port" class="form-control" id="port" value="<?= $data['port']; ?>">
                    </div>

                    <div class="form-group mb-3">
                        <label for="port">query port</label>
                        <input type="text" name="query_port" class="form-control" id="port" value="<?= $data['query_port']; ?>">
                    </div>

                    <div class="form-group mb-3">
                        <label for="rating">Рейтинг</label>
                        <input type="number" name="rating" class="form-control" id="rating" value="<?= $data['rating']; ?>">
                    </div>

                    <div class="form-group mb-3">
                        <label for="ban">Сервер в бане?</label>
                        <select class="form-control" name="ban" id="ban">
                            <option value="1" <?= $data['ban'] == '1' ? 'selected' : ''; ?>>Да</option>
                            <option value="0" <?= $data['ban'] == '0' ? 'selected' : ''; ?>>Нет</option>
                        </select>
                    </div>

                    <div class="form-group mb-3" id="ban_cause_block" style="<?= $data['ban'] == '1' ? '' : 'display:none;' ?>">
                        <label for="ban_cause">Причина бана</label>
                        <textarea class="form-control" name="ban_cause" id="ban_cause"><?= $data['ban_couse']; ?></textarea>
                    </div>

                    <script>
                        document.addEventListener('DOMContentLoaded', function() {
                            const banSelect = document.getElementById('ban');
                            const banBlock = document.getElementById('ban_cause_block');

                            function toggleBanReason() {
                                if (banSelect.value === '1') {
                                    banBlock.style.display = '';
                                } else {
                                    banBlock.style.display = 'none';
                                }
                            }
                            banSelect.addEventListener('change', toggleBanReason);
                            toggleBanReason();
                        });
                    </script>

                </div>
            </div>

            <div class="text-end mt-3">
                <button class="btn btn-warning" type="submit">Сохранить изменения</button>
            </div>
        </form>
    </div>
</div>

<!-- Платные услуги -->
<div class="card p-0">
    <div class="card-header border-bottom">
        <h5 class="card-title mb-0 text-primary">Платные услуги</h5>
    </div>

    <div class="card-body">
        <form action="#" id="paidServicesForm" method="post">
            <div class="row">
                <!-- Каждый блок в своей колонке -->
                <div class="col-md-6">
                    <div class="service-block border rounded-3 p-3 mb-3">
                        <h6 class="fw-bold mb-2"><i class="bi bi-trophy text-warning me-1"></i>TOP</h6>
                        <div class="form-group mb-2">
                            <label>Место</label>
                            <select class="form-control" name="top_enabled">
                                <option value="0">Не выбрана</option>
                                <?php foreach($topPlaces as $t): ?>
                                <option value="<?= $t['id']; ?>"
                                <?= ($t['status'] == '1' && !$t['currentServer']) ? 'disabled' : ''; ?>
                                <?= $data['top_enabled'] == $t['id'] ? 'selected' : ''; ?>>
                                Место #<?= $t['id']; ?>
                                </option>
                                <?php endforeach; ?>
                            </select>
                        </div>
                        <div class="form-group">
                            <label>Истекает</label>
                            <input type="date" class="form-control" name="top_expired_date"
                                   value="<?= $data['top_expired_date'] ? date('Y-m-d', $data['top_expired_date']) : ''; ?>">
                        </div>
                    </div>
                </div>

                <div class="col-md-6">
                    <div class="service-block border rounded-3 p-3 mb-3">
                        <h6 class="fw-bold mb-2"><i class="bi bi-star text-warning me-1"></i>VIP</h6>
                        <div class="form-group mb-2">
                            <label>Активно?</label>
                            <select class="form-control" name="vip_enabled">
                                <option value="1">Да</option>
                                <option value="0" <?= $data['vip_enabled'] === null ? 'selected' : ''; ?>>Нет</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label>Истекает</label>
                            <input type="date" class="form-control" name="vip_expired_date"
                                   value="<?= $data['vip_expired_date'] ? date('Y-m-d', $data['vip_expired_date']) : ''; ?>">
                        </div>
                    </div>
                </div>

                <div class="col-md-6">
                    <div class="service-block border rounded-3 p-3 mb-3">
                        <h6 class="fw-bold mb-2"><i class="bi bi-controller text-info me-1"></i>GameMenu</h6>
                        <div class="form-group mb-2">
                            <label>Активно?</label>
                            <select class="form-control" name="gamemenu_enabled">
                                <option value="1">Да</option>
                                <option value="0" <?= $data['gamemenu_enabled'] === null ? 'selected' : ''; ?>>Нет</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label>Истекает</label>
                            <input type="date" class="form-control" name="gamemenu_expired_date"
                                   value="<?= $data['gamemenu_expired_date'] ? date('Y-m-d', $data['gamemenu_expired_date']) : ''; ?>">
                        </div>
                    </div>
                </div>

                <div class="col-md-6">
                    <div class="service-block border rounded-3 p-3 mb-3">
                        <h6 class="fw-bold mb-2"><i class="bi bi-palette text-danger me-1"></i>Цветное выделение</h6>
                        <div class="form-group mb-2">
                            <label>Цвет (пример: red)</label>
                            <input type="text" name="color_enabled" class="form-control"
                                   value="<?= $data['color_enabled'] !== null ? $data['color_enabled'] : ''; ?>">
                        </div>
                        <div class="form-group">
                            <label>Истекает</label>
                            <input type="date" class="form-control" name="color_expired_date"
                                   value="<?= $data['color_expired_date'] ? date('Y-m-d', $data['color_expired_date']) : ''; ?>">
                        </div>
                    </div>
                </div>

                <div class="col-md-6">
                    <div class="service-block border rounded-3 p-3">
                        <h6 class="fw-bold mb-2"><i class="bi bi-lightning-charge text-warning me-1"></i>BOOST</h6>
                        <div class="form-group">
                            <label>Кол-во кругов</label>
                            <input type="number" class="form-control" name="boost" value="<?= $data['boost']; ?>">
                        </div>
                    </div>
                </div>
            </div>

            <div class="text-end mt-3">
                <button class="btn btn-primary" type="submit">Сохранить услуги</button>
            </div>
        </form>
    </div>

</div>

<script>
    $('#serverMainForm').ajaxForm({
        dataType: 'json',
        success: function(data) {
            const type = data.status === "success" ? 'success' : 'error';
            ShowModal(data.message || data.success || data.error, 'answer', type);
        },
    });

    $('#paidServicesForm').ajaxForm({
        url: 'edit-services?id=<?php echo $data['id'];?>',
        dataType: 'json',
        success: function(data) {
            const type = data.status === "success" ? 'success' : 'error';
            ShowModal(data.message || data.success || data.error, 'answer', type);
        },
    });
</script>
