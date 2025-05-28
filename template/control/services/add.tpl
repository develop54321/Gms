<div class="page-header">
    <div>
        <h1 class="page-title">Добавление новой услуги</h1>
    </div>
    <div class="ms-auto pageheader-btn">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="/control">Главная</a></li>
            <li class="breadcrumb-item"><a href="/control/services">Услуги</a></li>
            <li class="breadcrumb-item active" aria-current="page">Добавление новой услуги</li>
        </ol>
    </div>
</div>

<div class="card p-0">
    <div class="card-header border-bottom">
        <h5 class="card-title">Добавление новой услуги</h5>
    </div>

    <div class="card-body">


        <form action="#" id="servicesForm" method="post">
            <div class="form-group">
                <label for="servicesName">Название услуги</label>
                <input type="text" name="servicesName" class="form-control" id="servicesName">
            </div>
            <div class="form-group">
                <label for="servicesName">Тип услуги</label>
                <select name="servicesType" class="form-control" id="servicesType" onchange="services();">
                    <option value="top">TOP</option>
                    <option value="vip">VIP</option>
                    <option value="color">Выделение цветом</option>
                    <option value="boost">Буст</option>
                    <option value="gamemenu">Gamemenu</option>
                    <option value="votes">Голоса</option>
                    <option value="razz">Разбан сервера</option>
                </select>
            </div>

            <div class="form-group" id="servicesPeriod">
                <label for="servicesPeriod">Срок услуги(днях)</label>
                <input type="int" name="servicesPeriod" class="form-control">
            </div>

            <div class="form-group">
                <label for="servicesPrice">Цена услуги</label>
                <input type="int" name="servicesPrice" class="form-control" id="servicesPrice">
            </div>

            <div class="form-group">
                <label for="servicesName">Описание</label>
                <textarea name="text" class="form-control" id="text">

                </textarea>
            </div>

            <div class="form-group text-right m-b-0">
                <button class="btn btn-primary waves-effect waves-light" type="submit">
                    Добавить
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


    function services() {
        var type = $("#servicesType").val();
        var label = $("#servicesPeriod label");


        if (type == 'razz') {
            $("#servicesPeriod").hide();
        } else {
            $("#servicesPeriod").show();
        }


        // Изменение текста в label в зависимости от выбранного типа
        switch (type) {
            case 'top':
                label.text("Срок услуги (в днях)");
                break;
            case 'vip':
                label.text("Срок VIP услуги (в днях)");
                break;
            case 'color':
                label.text("Длительность выделения цветом (в днях)");
                break;
            case 'boost':
                label.text("Количество кругов");
                break;
            case 'gamemenu':
                label.text("Длительность услуги Gamemenu (в днях)");
                break;
            case 'votes':
                label.text("Количество голосов");
                break;
            default:
                label.text("Срок услуги (в днях)");
        }
    }
</script>
