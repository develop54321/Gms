<section class="page">
    <div class="container">
        <h1 class="content-title">
           Безопасность
        </h1>
        <hr/>


        <div class="row">

            <div class="col-md-2">
                <?php $url = "security";
                include("UserMenu.tpl"); ?>

            </div>

            <div class="col-md-10">


                    <div class="row">
                        <div class="col-md-5">
                            <form id="securityForm" method="post">

                            <div class="mb-3">
                                <label for="last_password">Старый пароль</label>
                                <input type="password" name="last_password" class="form-control" id="last_password" required="">
                            </div>

                            <div class="mb-3">
                                <label for="new_password">Новый пароль</label>
                                <input type="password" name="new_password" class="form-control" id="new_password" required="">
                            </div>

                            <div class="mb-3">
                                <label for="repeat_new_password">Повторите новый пароль</label>
                                <input type="password" name="repeat_new_password" class="form-control" id="repeat_new_password" required="">
                            </div>


                            <div class="mb-3">
                                <input type="submit" class="btn btn-sm btn-primary" value="Отправить"/>
                            </div>
                            </form>
                        </div>


                    </div>
            </div>
        </div>

    </div>
</section>


<script>
    $('#securityForm').ajaxForm({
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
</script>