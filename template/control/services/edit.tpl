<div class="page-header">
    <div>
        <h1 class="page-title">Изменение услуги</h1>
    </div>
    <div class="ms-auto pageheader-btn">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="/control">Главная</a></li>
            <li class="breadcrumb-item"><a href="/control/services">Услуги</a></li>
            <li class="breadcrumb-item active" aria-current="page">Изменение услуги</li>
        </ol>
    </div>
</div>

<div class="card p-0">
    <div class="card-header border-bottom">
        <h5 class="card-title">Изменение услуги - <?php echo $data['type']; ?></h5>
    </div>

    <div class="card-body">



        <form action="#" id="servicesForm" method="post">
            <div class="form-group">
                <label for="servicesName">Название услуги</label>
                <input type="text" name="servicesName" class="form-control" id="servicesName"
                       value="<?php echo $data['name']; ?>">
            </div>

            <?php if ($data['type'] != 'razz'): ?>
            <div class="form-group">
                <label for="servicesPeriod">Срок услуги(днях)</label>
                <input type="number" name="servicesPeriod" class="form-control" id="servicesPeriod"
                       value="<?php echo $data['period']; ?>">
                <small class="form-text text-muted">Базовый срок/цена — используется, если ниже не заданы отдельные тарифы.</small>
            </div>
            <?php endif; ?>

            <div class="form-group">
                <label for="servicesPrice">Цена услуги</label>
                <input type="number" name="servicesPrice" class="form-control" id="servicesPrice"
                       value="<?php echo $data['price']; ?>">
            </div>

            <?php if ($data['type'] != 'razz'): ?>
            <div class="form-group" id="periodsBlock">
                <label>Тарифы по срокам <small class="text-muted">(необязательно — если заданы, покупатель выбирает один из них)</small></label>

                <div class="mb-2">
                    <button type="button" class="btn btn-outline-secondary btn-sm" onclick="addPeriodRow(7, '')">+ 7 дней</button>
                    <button type="button" class="btn btn-outline-secondary btn-sm" onclick="addPeriodRow(15, '')">+ 15 дней</button>
                    <button type="button" class="btn btn-outline-secondary btn-sm" onclick="addPeriodRow(30, '')">+ 30 дней</button>
                    <button type="button" class="btn btn-outline-secondary btn-sm" onclick="addPeriodRow('', '')">+ Свой срок</button>
                </div>

                <div id="periodsList"></div>

                <input type="hidden" name="periodsData" id="periodsData" value="[]">
            </div>
            <?php endif; ?>

            <div class="form-group">
                <label for="servicesName">Описание</label>
                <textarea name="text" class="form-control" id="text"><?php echo $data['text']; ?></textarea>
            </div>


            <div class="form-group text-right m-b-0">
                <button class="btn btn-warning waves-effect waves-light" type="submit">
                    Изменить
                </button>


            </div>

        </form>

    </div>

</div>

<script>
    $('#servicesForm').ajaxForm({
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

    function addPeriodRow(period, price) {
        const row = $(
            '<div class="d-flex gap-2 align-items-center mb-2 period-row">' +
                '<input type="number" class="form-control period-input" placeholder="Срок (дней)" style="max-width:160px;">' +
                '<input type="number" class="form-control price-input" placeholder="Цена" style="max-width:160px;">' +
                '<button type="button" class="btn btn-outline-danger btn-sm" onclick="$(this).closest(\'.period-row\').remove(); syncPeriodsData();"><i class="fa fa-trash"></i></button>' +
            '</div>'
        );

        row.find('.period-input').val(period);
        row.find('.price-input').val(price);
        row.on('input', syncPeriodsData);

        $('#periodsList').append(row);
        syncPeriodsData();
    }

    function syncPeriodsData() {
        const data = [];

        $('.period-row').each(function () {
            const period = $(this).find('.period-input').val();
            const price = $(this).find('.price-input').val();
            if (period && price) data.push({period: parseInt(period, 10), price: parseInt(price, 10)});
        });

        $('#periodsData').val(JSON.stringify(data));
    }

    <?php foreach ($periods as $p): ?>
    addPeriodRow(<?php echo (int)$p['period']; ?>, <?php echo (int)$p['price']; ?>);
    <?php endforeach; ?>
</script>
