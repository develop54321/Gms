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


            <div class="form-group">
                <label for="servicesPeriod">Срок услуги(днях)</label>
                <input type="int" name="servicesPeriod" class="form-control" id="servicesPeriod"
                       value="<?php echo $data['period']; ?>">
            </div>

            <div class="form-group">
                <label for="servicesPrice">Цена услуги</label>
                <input type="int" name="servicesPrice" class="form-control" id="servicesPrice"
                       value="<?php echo $data['price']; ?>">
            </div>


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

    services();

    function services() {
        var type = $("#servicesType").val();

        if (type == 'razz') {
            $("#servicesPeriod").hide();
        } else {
            $("#servicesPeriod").show();
        }
    }
</script>
