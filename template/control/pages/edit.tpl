<div class="page-header">
    <div>
        <h1 class="page-title">Изменение страницы</h1>
    </div>
    <div class="ms-auto pageheader-btn">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="/control">Главная</a></li>
            <li class="breadcrumb-item"><a href="/control/pages">Страницы</a></li>
            <li class="breadcrumb-item active" aria-current="page">Изменение страницы</li>
        </ol>
    </div>
</div>


<div class="card p-0">
    <div class="card-header border-bottom">
        <h5 class="card-title">Изменение страницы</h5>
    </div>

    <div class="card-body">
        <h4 class="m-t-0 header-title"><b>Изменение страницы</b></h4>


        <form action="#" id="pagesForm" method="post">


            <div class="form-group">
                <label for="moderation">Заголовок</label>
                <input type="text" name="title" class="form-control" value="<?php echo $data['title']; ?>"/>
            </div>


            <div class="form-group">
                <label for="rating">Содержимое</label>
                <textarea name="text" class="form-control" rows="25"><?php echo $data['text']; ?></textarea>
            </div>

            <div class="form-group text-right m-b-0">
                <button class="btn btn-warning waves-effect waves-light" type="submit">Изменить</button>
            </div>
        </form>
    </div>
</div>


<script>
    $('#pagesForm').ajaxForm({
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