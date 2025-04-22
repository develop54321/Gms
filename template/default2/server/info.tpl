<section class="page server-info">
    <div class="container">
        <h1 class="content-title">
            Информация о сервере - <?php echo \widgets\server\hostname\Hostname::run($data['hostname']);?>
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
                        <p>Название сервера: <span class="name"><?php echo \widgets\server\hostname\Hostname::run($data['hostname']);?></span></p>
                        <p>Игра: <span class="game"> <?php echo $data['game_name'];?></span> </p>
                        <p>Адрес: <span class="address"><?php echo $data['ip'];?>:<?php echo $data['port'];?></span></p>
                        <p>Игроков: <span class="players"><?php echo $data['players'];?>/<?php echo $data['max_players'];?></span></p>
                        <p>Карта: <span class="map"><?php echo $data['map'];?></span> </p>


                        <p>Статус:
                        <span class="<?php if ($data['status']):?>status-online<?php else:?>status-offline<?php endif;?>">
                            <?php echo $data['status'];?>
                        </span>
                        </p>

                        <p>
                            Добавлен в мониторинг: <span class="created-at"><?php echo date("d.m.Y [H:i]", $data['date_add']);?></span>
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
                            <a href="#" onclick="ShowModal('<?=$data['id'];?>', 'vote', 'minus');return false;"><i class="fa fa-thumbs-down"></i></a>
                            <label id="vote<?php echo $data['id'];?>" class="rating-bg"><?php echo $data['rating'];?></label>
                            <a href="#" onclick="ShowModal('<?=$data['id'];?>', 'vote', 'plus');return false;"><i class="fa fa-thumbs-up"></i></a>

                        </p>

                        <?php if(!empty($data['description'])):?>
                            <p>Описание: <?php  echo $data['description'];?></p>
                        <?php endif;?>



                        <hr>

                        <h3>Платные услуги</h3>
                        <ul class="list-group">
                            <?php if($data['top_enabled'] != '0'):?>
                                <li class="list-group-item">
                                    Премиум место(Место №<?php echo $data['top_enabled'];?>)<br/>
                                    Оплачено до: <?php echo date("d.m.Y [H:i]", $data['top_expired_date']);?>
                                </li>
                            <?php endif;?>

                            <?php if($data['vip_enabled'] != '0'):?>
                                <li class="list-group-item">
                                    VIP статус<br/>
                                    Оплачено до: <?php echo date("d.m.Y [H:i]", $data['vip_expired_date']);?>
                                </li>
                            <?php endif;?>

                            <?php if($data['color_enabled'] != '0'):?>
                                <li class="list-group-item">
                                    Выделение цветом<br/>
                                    Оплачено до: <?php echo date("d.m.Y [H:i]", $data['color_expired_date']);?>
                                </li>
                            <?php endif;?>


                            <?php if($data['boost'] != '0'):?>
                                <li class="list-group-item">
                                    Буст:<br/>
                                    осталось кругов: <?php echo $data['boost'];?>
                                </li>
                            <?php endif;?>

                        </ul>

                                 <a class="btn btn-primary btn-sm mt-2" href="/pay/<?php echo $data['id'];?>/select"> Заказать платную услугу</a>
                        <hr>


                        <h3>Комментарии к серверу</h3>
                            <form id="addComment" method="post">
                                <input type="hidden" name="id" value="<?php echo $data['id'];?>"/>
                                <textarea class="form-control" name="comment" style="resize: none;"
                                          placeholder="Оставьте свой комментарий..." rows="3"></textarea>
                                <br/>
                                <input type="submit" class="btn btn-primary btn-sm mb-2" value="Отправить"/>
                            </form>

                        <div class="comments">
                            <?php if(empty($comments)):?>
                                <div class="alert alert-warning" style="margin: 3px 0;">В данный момент комментариев отсутствует
                                </div>
                            <?php endif;?>
                            <?php foreach($comments as $c):?>
                                <div class="comment">
                                    <?php if ($c['img'] !== null):?>
                                    <div class="img-user">
                                        <img style="width: 24px;" src="<?php echo $c['img'];?>" alt="user avatar"/>
                                    </div>
                                    <?php endif;?>
                                    <div class="text">
                                        <div class="author">
                                            <?php echo $c['lastname'];?>
                                        </div>
                                        <?php echo $c['text'];?>

                                        <hr/>

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

                    <a onclick="ShowModal('<?= $data['id']; ?>', 'showPlayers');return false;" class="btn btn-success players-btn mt-2 btn-sm w-100">Показать игроков</a>
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

            </script>
        <?php endif;?>


</div>
</section>
