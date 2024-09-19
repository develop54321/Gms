<section class="page">
    <div class="container">
        <h1 class="content-title">
            Информация о сервере - <?php echo $data['hostname'];?>
        </h1>
        <hr/>

        <?php if($data['ban'] === 1):?>
            <div class="alert alert-danger">
                <b>Внимание!</b>
                <p>Данный сервер заблокирован, за нарушение правил использование сервиса.</p>
            </div>

        <?php else:?>
        <div class="container my-5">
            <div class="row">

                <div class="col-lg-8 mb-4">
                    <div class="server-info">
                        <p>Название сервера: <strong><?php echo $data['hostname'];?></strong></p>
                        <p>IP: <strong><?php echo $data['ip'];?>:<?php echo $data['port'];?></strong></p>
                        <p>Игроков: <strong><?php echo $data['players'];?>/<?php echo $data['max_players'];?></strong></p>
                        <p>Карта: <?php echo $data['map'];?></p>

                        <p>Игра: <?php widgets\server\game\Status::run($data['game']);?></p>
                        <p>Статус: <?php echo $data['status'];?></p>

                        <p>
                            Добавлен в мониторинг: <?php echo date("d.m.Y [H:i]", $data['date_add']);?>
                        </p>

                        <p>
                            Владелец:
                            <?php if ($current_user):?>
                                <?php if ($current_user['id'] !== $data['id_user']):?>
                                    <a href="/server/verification?id=<?php echo $data['id'];?>">(Это Вы?)</a>
                                <?php else:?>
                                    <?php echo $ownerName;?>
                                <?php endif;?>
                            <?php else:?>
                                <?php echo $ownerName ?? 'Гость';?>
                            <?php endif;?>
                        </p>

                        <p>
                            Рейтинг:
                            <a href="#" onclick="ShowModal('<?=$data['id'];?>', 'vote', 'minus');return false;"><i class="fa fa-minus"></i></a>
                            <label id="vote<?php echo $data['id'];?>" class="rating-bg"><?php echo $data['rating'];?></label>
                            <a href="#" onclick="ShowModal('<?=$data['id'];?>', 'vote', 'plus');return false;"><i class="fa fa-plus"></i></a>
                        </p>

                        <?php if(!empty($data['description'])):?>
                            <p>Описание: <?php  echo $data['description'];?></p>
                        <?php endif;?>



                        <div class="progress" style="margin: 10px;">
                            <div class="progress-bar"
                                 style="width: <?php echo $data['show_players'];?>;"> <?php echo $data['show_players'];?></div>
                        </div>
                        <hr>

                        <h3>Платные услуги</h3>
                        <ul class="list-group">
                            <li class="list-group-item">VIP доступ - <strong>5$</strong></li>
                            <li class="list-group-item">Премиум скины - <strong>10$</strong></li>
                            <li class="list-group-item">Супер оружие - <strong>7$</strong></li>
                        </ul>

                                 <a class="btn btn-outline-success btn-sm mt-2" href="/pay/server?id=<?php echo $data['id'];?>"> Заказать платную услугу</a>
<!--                <table class="table">-->
<!---->
<!---->
<!--                    --><?php //if($data['top_enabled'] != '0'):?>
<!--                    <tr>-->
<!--                        <td>-->
<!--                            Премиум место: (Место № --><?php //echo $data['top_enabled'];?><!--) Оплачено-->
<!--                            до: --><?php //echo date("d.m.Y [H:i]", $data['top_expired_date']);?>
<!--                        </td>-->
<!--                    </tr>-->
<!--                    --><?php //endif;?>
<!---->
<!--                    --><?php //if($data['vip_enabled'] != '0'):?>
<!--                    <tr>-->
<!--                        <td>-->
<!--                            VIP статус: Оплачено до: --><?php //echo date("d.m.Y [H:i]", $data['vip_expired_date']);?>
<!--                        </td>-->
<!--                    </tr>-->
<!--                    --><?php //endif;?>
<!---->
<!---->
<!--                    --><?php //if($data['color_enabled'] != '0'):?>
<!--                    <tr>-->
<!--                        <td>-->
<!--                            Выделение цветом: Оплачено-->
<!--                            до: --><?php //echo date("d.m.Y [H:i]", $data['color_expired_date']);?>
<!--                        </td>-->
<!--                    </tr>-->
<!--                    --><?php //endif;?>
<!---->
<!--                    --><?php //if($data['boost'] != '0'):?>
<!--                    <tr>-->
<!--                        <td>-->
<!--                            Boost: Осталось кругов: --><?php //echo $data['boost'];?>
<!--                        </td>-->
<!--                    </tr>-->
<!--                    --><?php //endif;?>
<!---->
<!--                    --><?php //if($data['gamemenu_enabled'] != '0'):?>
<!--                    <tr>-->
<!--                        <td>-->
<!--                            GameMenu: Оплачено до: --><?php //echo date("d.m.Y [H:i]", $data['gamemenu_expired_date']);?>
<!--                        </td>-->
<!--                    </tr>-->
<!--                    --><?php //endif;?>
<!---->
<!--                    --><?php //if($data['befirst_enabled'] == '0' and $data['top_enabled'] == '0' and $data['vip_enabled'] == '0' and $data['boost'] == '0' and $data['color_enabled'] == '0' and $data['gamemenu_enabled'] == '0'):?>
<!--                    <tr>-->
<!--                        <td>-->
<!--                        </td>-->
<!--                    </tr>-->
<!--                    --><?php //endif;?>
<!--                </table>-->

                        <hr>


                        <h3>Комментарии к серверу</h3>
                            <form id="addComment" method="post">
                                <input type="hidden" name="id" value="<?php echo $data['id'];?>"/>
                                <textarea class="form-control" name="comment" style="resize: none;"
                                          placeholder="Оставьте свой комментарий..." rows="3"></textarea>
                                <br/>
                                <input type="submit" class="btn btn-primary" value="Отправить"/>
                            </form>

                        <div class="comments">
                            <?php if(empty($comments)):?>
                                <div class="alert alert-warning" style="margin: 3px 0;">В данный момент комментарьев отсутсвует
                                </div>
                            <?php endif;?>
                            <?php foreach($comments as $c):?>
                                <div class="comment">
                                    <div class="img-user">
                                        <img src="<?php echo $c['img'];?>" alt="user avatar"/>
                                    </div>
                                    <div class="text">
                                        <div class="author">
                                            <?php echo $c['lastname'];?>
                                        </div>
                                        <?php echo $c['text'];?>

                                        <div class="date"><?php echo date("d.m.Y H:i", $c['date_create']);?></div>
                                    </div>
                                    <div class="clearfix"></div>
                                </div>
                            <?php endforeach;?>
                        </div>

                    </div>
                </div>


                <div class="col-lg-4">
                    <h2>Карта сервера</h2>

                    <img class="w-100" src="<?php echo $data['img_map'];?>" alt="<?php echo $data['map'];?>">

                    <button type="button" class="btn btn-success players-btn mt-2">Показать игроков</button>
                </div>
            </div>
        </div>


            <script>
                $('#addComment').ajaxForm({
                    dataType: 'json',
                    url: "/server/addcomment",
                    success: function (data) {
                        switch (data.status) {
                            case "error":
                                ShowModal(data.error, 'answer', 'error');
                                break;

                            case "success":
                                ShowModal(data.success, 'answer', 'success');
                                setTimeout('location.reload();', 2500);
                                break;
                        }
                    },
                });


                var id = <?php echo $data['id'];?>
                ;
                //setInterval(getPlayers, 5000);
                getPlayers();

                function getPlayers() {
                    $.ajax({
                        url: "/server/getplayers",
                        data: {'id':id},
                        success: function (data) {
                            $("#contentPlayers").html(data);
                        }
                    });
                }

            </script>
        <?php endif;?>


</div>
</section>
