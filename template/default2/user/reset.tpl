<section class="page pay">
    <div class="container">
        <h1 class="content-title">
            Восстановления пароля
        </h1>
        <hr/>

        <?php if (isset($password)): ?>
            <p>
                Ваш новый пароль: <code><?php echo $password; ?></code>
            </p>
        <?php else: ?>
        <form id="resetForm" method="post">
            <div class="row">
                <div class="col-md-5">

                    <div class="mb-3">
                        <label for="email">Электронная почта</label>
                        <input type="email" name="email" class="form-control" id="email">
                    </div>

                </div>
            </div>
            <div class="mb-3">
                <input type="submit" class="btn btn-primary" value="Отправить"/>
            </div>

        </form>
    </div>
</section>
<script>
    $(document).ready(function () {
        $('#resetForm').ajaxForm({
            dataType: "json",
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
    });
</script>
<?php endif; ?>