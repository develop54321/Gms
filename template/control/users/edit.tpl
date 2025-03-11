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
                                <a class="input-group-addon btn btn-primary" title="Сгенерировать ключ" onclick="generateKey(16);"><i class="fa fa-gears"></i></a>
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

            <button class="btn btn-warning waves-effect waves-light" type="submit">
                Изменить
            </button>

        </form>
    </div>

</div>


<script>
    var MD5 = function (d) {
        result = M(V(Y(X(d), 8 * d.length)));
        return result.toLowerCase()
    };

    function M(d) {
        for (var _, m = "0123456789ABCDEF", f = "", r = 0; r < d.length; r++) _ = d.charCodeAt(r), f += m.charAt(_ >>> 4 & 15) + m.charAt(15 & _);
        return f
    }

    function X(d) {
        for (var _ = Array(d.length >> 2), m = 0; m < _.length; m++) _[m] = 0;
        for (m = 0; m < 8 * d.length; m += 8) _[m >> 5] |= (255 & d.charCodeAt(m / 8)) << m % 32;
        return _
    }

    function V(d) {
        for (var _ = "", m = 0; m < 32 * d.length; m += 8) _ += String.fromCharCode(d[m >> 5] >>> m % 32 & 255);
        return _
    }

    function Y(d, _) {
        d[_ >> 5] |= 128 << _ % 32, d[14 + (_ + 64 >>> 9 << 4)] = _;
        for (var m = 1732584193, f = -271733879, r = -1732584194, i = 271733878, n = 0; n < d.length; n += 16) {
            var h = m, t = f, g = r, e = i;
            f = md5_ii(f = md5_ii(f = md5_ii(f = md5_ii(f = md5_hh(f = md5_hh(f = md5_hh(f = md5_hh(f = md5_gg(f = md5_gg(f = md5_gg(f = md5_gg(f = md5_ff(f = md5_ff(f = md5_ff(f = md5_ff(f, r = md5_ff(r, i = md5_ff(i, m = md5_ff(m, f, r, i, d[n + 0], 7, -680876936), f, r, d[n + 1], 12, -389564586), m, f, d[n + 2], 17, 606105819), i, m, d[n + 3], 22, -1044525330), r = md5_ff(r, i = md5_ff(i, m = md5_ff(m, f, r, i, d[n + 4], 7, -176418897), f, r, d[n + 5], 12, 1200080426), m, f, d[n + 6], 17, -1473231341), i, m, d[n + 7], 22, -45705983), r = md5_ff(r, i = md5_ff(i, m = md5_ff(m, f, r, i, d[n + 8], 7, 1770035416), f, r, d[n + 9], 12, -1958414417), m, f, d[n + 10], 17, -42063), i, m, d[n + 11], 22, -1990404162), r = md5_ff(r, i = md5_ff(i, m = md5_ff(m, f, r, i, d[n + 12], 7, 1804603682), f, r, d[n + 13], 12, -40341101), m, f, d[n + 14], 17, -1502002290), i, m, d[n + 15], 22, 1236535329), r = md5_gg(r, i = md5_gg(i, m = md5_gg(m, f, r, i, d[n + 1], 5, -165796510), f, r, d[n + 6], 9, -1069501632), m, f, d[n + 11], 14, 643717713), i, m, d[n + 0], 20, -373897302), r = md5_gg(r, i = md5_gg(i, m = md5_gg(m, f, r, i, d[n + 5], 5, -701558691), f, r, d[n + 10], 9, 38016083), m, f, d[n + 15], 14, -660478335), i, m, d[n + 4], 20, -405537848), r = md5_gg(r, i = md5_gg(i, m = md5_gg(m, f, r, i, d[n + 9], 5, 568446438), f, r, d[n + 14], 9, -1019803690), m, f, d[n + 3], 14, -187363961), i, m, d[n + 8], 20, 1163531501), r = md5_gg(r, i = md5_gg(i, m = md5_gg(m, f, r, i, d[n + 13], 5, -1444681467), f, r, d[n + 2], 9, -51403784), m, f, d[n + 7], 14, 1735328473), i, m, d[n + 12], 20, -1926607734), r = md5_hh(r, i = md5_hh(i, m = md5_hh(m, f, r, i, d[n + 5], 4, -378558), f, r, d[n + 8], 11, -2022574463), m, f, d[n + 11], 16, 1839030562), i, m, d[n + 14], 23, -35309556), r = md5_hh(r, i = md5_hh(i, m = md5_hh(m, f, r, i, d[n + 1], 4, -1530992060), f, r, d[n + 4], 11, 1272893353), m, f, d[n + 7], 16, -155497632), i, m, d[n + 10], 23, -1094730640), r = md5_hh(r, i = md5_hh(i, m = md5_hh(m, f, r, i, d[n + 13], 4, 681279174), f, r, d[n + 0], 11, -358537222), m, f, d[n + 3], 16, -722521979), i, m, d[n + 6], 23, 76029189), r = md5_hh(r, i = md5_hh(i, m = md5_hh(m, f, r, i, d[n + 9], 4, -640364487), f, r, d[n + 12], 11, -421815835), m, f, d[n + 15], 16, 530742520), i, m, d[n + 2], 23, -995338651), r = md5_ii(r, i = md5_ii(i, m = md5_ii(m, f, r, i, d[n + 0], 6, -198630844), f, r, d[n + 7], 10, 1126891415), m, f, d[n + 14], 15, -1416354905), i, m, d[n + 5], 21, -57434055), r = md5_ii(r, i = md5_ii(i, m = md5_ii(m, f, r, i, d[n + 12], 6, 1700485571), f, r, d[n + 3], 10, -1894986606), m, f, d[n + 10], 15, -1051523), i, m, d[n + 1], 21, -2054922799), r = md5_ii(r, i = md5_ii(i, m = md5_ii(m, f, r, i, d[n + 8], 6, 1873313359), f, r, d[n + 15], 10, -30611744), m, f, d[n + 6], 15, -1560198380), i, m, d[n + 13], 21, 1309151649), r = md5_ii(r, i = md5_ii(i, m = md5_ii(m, f, r, i, d[n + 4], 6, -145523070), f, r, d[n + 11], 10, -1120210379), m, f, d[n + 2], 15, 718787259), i, m, d[n + 9], 21, -343485551), m = safe_add(m, h), f = safe_add(f, t), r = safe_add(r, g), i = safe_add(i, e)
        }
        return Array(m, f, r, i)
    }

    function md5_cmn(d, _, m, f, r, i) {
        return safe_add(bit_rol(safe_add(safe_add(_, d), safe_add(f, i)), r), m)
    }

    function md5_ff(d, _, m, f, r, i, n) {
        return md5_cmn(_ & m | ~_ & f, d, _, r, i, n)
    }

    function md5_gg(d, _, m, f, r, i, n) {
        return md5_cmn(_ & f | m & ~f, d, _, r, i, n)
    }

    function md5_hh(d, _, m, f, r, i, n) {
        return md5_cmn(_ ^ m ^ f, d, _, r, i, n)
    }

    function md5_ii(d, _, m, f, r, i, n) {
        return md5_cmn(m ^ (_ | ~f), d, _, r, i, n)
    }

    function safe_add(d, _) {
        var m = (65535 & d) + (65535 & _);
        return (d >> 16) + (_ >> 16) + (m >> 16) << 16 | 65535 & m
    }

    function bit_rol(d, _) {
        return d << _ | d >>> 32 - _
    }


    $('#userEdit').ajaxForm({
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

    function changeRole() {
        role = $("#role").val();
        if (role == 'partner') {
            $("#partnerStatus").show();
        } else {
            $("#partnerStatus").hide();
        }
    }


    function generateKey(len) {
        var ints = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];
        var chars = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z'];
        var out = '';
        for (var i = 0; i < len; i++) {
            var ch = Math.random(1, 2);
            if (ch < 0.5) {
                var ch2 = Math.ceil(Math.random(1, ints.length) * 10);
                out += ints[ch2];
            } else {
                var ch2 = Math.ceil(Math.random(1, chars.length) * 10);
                out += chars[ch2];
            }
        }
        out = MD5(out);
        $("#key").val(out);
    }
</script>

  