<div class="page-header">
    <div>
        <h1 class="page-title">Изменение поста</h1>
    </div>
    <div class="ms-auto pageheader-btn">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="/control">Главная</a></li>
            <li class="breadcrumb-item"><a href="/control/news">Новости</a></li>
            <li class="breadcrumb-item active" aria-current="page">Изменение поста</li>
        </ol>
    </div>
</div>


<div class="card p-0">
    <div class="card-header border-bottom">
        <h5 class="card-title">Изменение поста</h5>
    </div>

    <div class="card-body">
        <form action="#" id="newsForm" method="post">


            <div class="form-group">
                <label for="moderation">Заголовок</label>
                <input type="text" name="title" class="form-control" value="<?php echo $data['title']; ?>"/>
            </div>


            <div class="form-group">
                <label for="rating">Текст</label>
                <textarea name="text" class="form-control" rows="20"><?php echo $data['text']; ?></textarea>
            </div>

            <div class="form-group">
                <label for="rating">Дата публикации</label>
                <input type="date" name="date_create" class="form-control" value="<?php echo date("Y-m-d", $data['date_create']); ?>">
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
    $('#newsForm').ajaxForm({
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