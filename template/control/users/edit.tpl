<div class="page-header">
    <div>
        <h1 class="page-title">Пользователи</h1>
    </div>
    <div class="ms-auto pageheader-btn">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="/control">Главная</a></li>
            <li class="breadcrumb-item"><a href="/control/users">Пользователи</a></li>
            <li class="breadcrumb-item active" aria-current="page">Изменение пользователя</li>
        </ol>
    </div>
</div>


<div class="card p-0">
    <div class="card-header border-bottom">
        <h5 class="card-title">Изменение пользователя</h5>
    </div>

    <div class="card-body">
        <form action="#" id="userEdit" method="post">
            <div class="row">
                <div class="col-md-6">
                    <div class="form-group">
                        <label for="firstname">Имя</label>
                        <input type="text" name="firstname" class="form-control" required="" value="<?php echo $data['firstname']; ?>"/>
                    </div>


                    <div class="form-group">
                        <label for="lastname">Фамилия</label>
                        <input type="text" name="lastname" class="form-control" required="" value="<?php echo $data['lastname']; ?>"/>
                    </div>


                    <div class="form-group">
                        <label for="email">Почта</label>
                        <input type="email" name="email" class="form-control" required="" value="<?php echo $data['email']; ?>"/>
                    </div>

                    <div class="form-group">
                        <label for="email">Пароль</label>
                        <input type="text" name="password" class="form-control" value=""/>
                    </div>

                </div>


                <div class="col-md-6">
                    <div class="form-group">
                        <label for="role">Роль</label>
                        <select name="role" class="form-control" id="role" onchange="changeRole();">
                            <option value="user">Пользователь</option>
                            <option value="admin" <?php if ($data['role'] === 'admin'): ?>selected=""<?php endif; ?>>
                                Администратор
                            </option>
                            <option value="partner" <?php if ($data['role'] === 'partner'): ?>selected=""<?php endif; ?>>
                                Партнер
                            </option>
                            <option value="banned" <?php if ($data['role'] === 'banned'): ?>selected=""<?php endif; ?>>
                                Заблокирован
                            </option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="balance">Лицевой счет</label>
                        <input type="number" name="balance" class="form-control" required="" value="<?php echo $data['balance']; ?>"/>
                    </div>

                    <div class="form-group">
                        <label for="date_reg">Дата регистрации</label>
                        <input type="text" class="form-control disabled" value="<?php echo date("d:m:Y H:i", $data['date_reg']); ?>" disabled/>
                    </div>


                    <div id="partnerStatus"
                         style="<?php if ($data['role'] == 'partner'): ?>display: block;<?php else: ?>display: none;<?php endif; ?>">
                        <div class="form-group">
                            <label for="status">Api Логин</label>
                            <input type="text" name="api_login" class="form-control" value="<?php echo $data['api_login'] ?? null; ?>"/>
                        </div>

                        <div class="form-group">
                            <label for="status">Api Ключ</label>
                            <div class="input-group m-t-10">
                                <input type="text" id="key" name="api[key]" class="form-control" minlength="16" value="<?php echo $api_params['key_api'] ?? null; ?>">
                                <a class="input-group-addon btn btn-primary" title="Сгенерировать ключ" onclick="generateKey(32);"><i class="fa fa-gears"></i></a>
                            </div>

                        </div>

                        <div class="form-group">
                            <label for="status">Размер скидки</label>
                            <div class="input-group">
                                <span class="input-group-addon"><i class="fa fa-percent"></i></span>
                                <input type="number" name="api[discount]" class="form-control"
                                       value="<?php echo $api_params['discount_api']; ?>">
                            </div>
                        </div>
                    </div>

                </div>
            </div>


            <div class="clearfix"></div>

            <button class="btn btn-warning" type="submit">
                Изменить
            </button>

        </form>
    </div>

</div>


<script>
    $(document).ready(function() {
        var $btn = $(this).find('button[type="submit"]');


        $('#userEdit').ajaxForm({
            dataType: 'json',
            beforeSubmit: function () {
                $btn.toggleButtonLoader(true);

            },
            success: function (data) {
                switch (data.status) {
                    case "error":
                        ShowModal(data.error, 'answer', 'error');
                        break;

                    case "success":
                        ShowModal(data.success, 'answer', 'success');
                        break;
                }
                $btn.toggleButtonLoader(false);
            },


            error: function (xhr, status, error) {
                $btn.toggleButtonLoader(false);
                console.log(xhr.status);
                console.log(error);
            }
        });
    });
        function changeRole() {
            role = $("#role").val();
            if (role == 'partner') {
                $("#partnerStatus").show();
            } else {
                $("#partnerStatus").hide();
            }
        }

        function generateKey(length) {
            // Возможные символы для генерации строки
            const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
            let result = '';

            for (let i = 0; i < length; i++) {
                // Выбираем случайный символ из строки chars
                result += chars.charAt(Math.floor(Math.random() * chars.length));
            }

            $("#key").val(result);
        }



</script>

  