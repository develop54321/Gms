<div class="page-header">
    <div>
        <h1 class="page-title">Редактирование комментария</h1>
    </div>
    <div class="ms-auto pageheader-btn">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="/control">Главная</a></li>
            <li class="breadcrumb-item"><a href="/control/comments">Комментарии</a></li>
            <li class="breadcrumb-item active" aria-current="page">Редактирование комментария</li>
        </ol>
    </div>
</div>

<div class="card p-0">
    <div class="card-header border-bottom">
        <h5 class="card-title">Редактирование комментария</h5>
    </div>

    <div class="card-body">
        <form action="#" id="commentsForm" method="post">


                <div class="form-group">
                    <label for="moderation">Модерация</label>
                    <select name="moderation" class="form-control" id="moderation">
                        <option value="1">Показывается</option>
                        <option value="0" <?php if ($data['moderation'] == '0'): ?>selected<?php endif; ?>>Отклонено
                        </option>
                    </select>
                </div>

                <div class="form-group">
                    <label for="moderation">Пользователь(id)</label>
                    <input type="int" name="id_user" class="form-control" value="<?= $data['id_user']; ?>"/>
                </div>

                <div class="form-group">
                    <label for="moderation">Сервер(id)</label>
                    <input type="int" name="id_server" class="form-control" value="<?= $data['id_server']; ?>"/>
                </div>


                <div class="form-group">
                    <label for="rating">Текст</label>
                    <textarea name="text" class="form-control"><?= $data['text']; ?></textarea>
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
    $('#commentsForm').ajaxForm({
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
        if (type == 'color') {
            $("#moreParams").show();
        } else {
            $("#moreParams").hide();
        }
    }
</script>
