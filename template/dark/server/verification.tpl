<section class="page">
    <div class="container">
        <h1 class="content-title mb-3">Верификация сервера</h1>
        <hr/>

        <div class="alert alert-info">
            <b>Как происходит процесс смены владельца?</b>
            <p class="mb-0 mt-2">
                Мы автоматически проверяем текущее название сервера.
            </p>
        </div>

        <div class="card p-4 mb-3" style="max-width:560px;">
                <b>1.</b> Переименуйте сервер в:
                <div class="verify-code mt-2">
                    <code id="server-name" class="me-2">
                        ServerVerification_<?php echo $data['verification_rand']; ?>
                    </code>
                    <button class="btn btn-sm btn-outline-secondary ms-auto" id="copy-name">
                        Скопировать
                    </button>
                </div>

                <small class="text-muted d-block mt-3">
                    Автоматическая проверка выполняется каждые <b>10 секунд</b>
                </small>

                <small class="text-muted">
                    Статус: <span id="check-status">ожидание…</span>
                </small>
        </div>

        <button class="btn btn-primary" id="verify-btn">
            Проверить вручную
        </button>
    </div>
</section>
<script>
    $(function () {
        const statusEl = $('#check-status');
        const verifyBtn = $('#verify-btn');
        let checking = false;
        let intervalId = null;


        $('#copy-name').on('click', function () {
            const text = $('#server-name').text();
            navigator.clipboard.writeText(text).then(() => {
                $(this).text('Скопировано ✓').prop('disabled', true);
            });
        });

        function runVerification(auto = false) {
            if (checking) return;
            checking = true;

            if (!auto) {
                verifyBtn.prop('disabled', true).text('Проверка...');
            }

            statusEl.text('проверка...');

            $.ajax({
                url: '/server/verification?id=<?php echo $data['id']; ?>',
                dataType: 'json',
                success: function (data) {
                    if (data.status === 'success') {
                        statusEl.text('успешно ✓');
                        ShowModal(data.success, 'answer', 'success');
                        clearInterval(intervalId);
                        verifyBtn.prop('disabled', true).text('Подтверждено');
                    } else {
                        statusEl.text('не найдено');
                    }
                },
                error: function () {
                    statusEl.text('ошибка соединения');
                },
                complete: function () {
                    checking = false;
                    if (!auto) {
                        verifyBtn.prop('disabled', false).text('Проверить вручную');
                    }
                }
            });
        }


        verifyBtn.on('click', function () {
            runVerification(false);
        });

        intervalId = setInterval(function () {
            runVerification(true);
        }, 10000);

    });
</script>

