<div class="page-header">
    <div>
        <h1 class="page-title">Добавление новой игры</h1>
    </div>
    <div class="ms-auto pageheader-btn">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="/control">Главная</a></li>
            <li class="breadcrumb-item"><a href="/control/games">Игры</a></li>
            <li class="breadcrumb-item active" aria-current="page">Добавление новой игры</li>
        </ol>
    </div>
</div>


<div class="card p-0">
    <div class="card-header border-bottom">
        <h5 class="card-title">Добавление новой игры</h5>
    </div>

    <div class="card-body">


        <form action="#" id="gameForm" method="post">

            <div class="form-group">
                <label for="game">Выберите игру</label>
                <select name="game" class="form-control" id="game" required>
                    <?php foreach ($games as $row): ?>
                        <option value="<?php echo $row['id']; ?>"><?php echo $row['game']; ?></option>
                    <?php endforeach; ?>
                </select>
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
    $('#gameForm').ajaxForm({
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
