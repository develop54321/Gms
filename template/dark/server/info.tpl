<section class="page server-info-page">
    <div class="container">
        <div class="d-flex justify-content-start align-items-center flex-wrap" style="gap: 16px;">
            <a href="/server/<?php echo $data['ip'];?>:<?php echo $data['port'];?>/banners" class="btn btn-primary btn-sm mb-2">
                <i class="fa fa-picture-o"></i> Баннер для форума
            </a>
            <h1 class="content-title mb-2">
                Информация о сервере - <?php echo \widgets\server\hostname\Hostname::run($data['hostname']);?>
            </h1>
        </div>
        <hr/>

        <?php if($data['ban'] === 1):?>
            <div class="alert alert-danger">
                <b>Внимание!</b>
                <p>Данный сервер заблокирован, за нарушение правил использование сервиса.</p>
            </div>

        <?php else:
            $maxPlayers = (int)$data['max_players'];
            $curPlayers = (int)$data['players'];
            $fillPct = $maxPlayers > 0 ? min(100, (int)round($curPlayers / $maxPlayers * 100)) : 0;
            if ($fillPct >= 90) { $fillLevel = 'hot'; }
            elseif ($fillPct >= 50) { $fillLevel = 'mid'; }
            else { $fillLevel = 'low'; }
        ?>

        <div class="sv-hero<?php echo $data['color_enabled'] !== null ? ' has-color' : ''; ?>"<?php if ($data['color_enabled'] !== null): ?> style="--sv-color: <?php echo $data['color_enabled']; ?>;"<?php endif; ?>>
            <div class="sv-hero-main">
                <div class="sv-hero-icon"><?php widgets\server\game\GameIcon::run($data['game']);?></div>

                <div class="sv-hero-info">
                    <div class="sv-hero-badges">
                        <?php if ($data['status'] == 1):?>
                            <span class="status-online">Онлайн</span>
                        <?php else:?>
                            <span class="status-offline">Выключен</span>
                        <?php endif;?>
                        <span class="sv-hero-game-name"><?php echo $data['game_name'];?></span>
                        <?php if ($data['vip_enabled'] !== null): ?>
                            <span class="badge badge-vip"><i class="fa fa-star"></i> VIP</span>
                        <?php endif; ?>
                    </div>

                    <h2 class="sv-hero-title"><?php echo \widgets\server\hostname\Hostname::run($data['hostname']);?></h2>

                    <div class="sv-hero-addr">
                        <span class="address" id="server-<?=$data['id'];?>"><?php echo $data['host'] ?? $data['ip'];?>:<?php echo $data['port'];?></span>
                        <button class="copy-btn" onclick="copyToClipboard('server-<?=$data['id'];?>')">
                            <i class="fa fa-copy"></i>
                        </button>
                    </div>
                </div>

                <div class="sv-hero-actions">
                    <div class="sv-hero-rating">
                        <a href="#" onclick="ShowModal('<?=$data['id'];?>', 'vote', 'minus');return false;"><i class="fa fa-thumbs-down"></i></a>
                        <label id="vote<?php echo $data['id'];?>" class="rating-bg"><?php echo $data['rating'];?></label>
                        <a href="#" onclick="ShowModal('<?=$data['id'];?>', 'vote', 'plus');return false;"><i class="fa fa-thumbs-up"></i></a>
                    </div>

                    <?php if ($current_user):?>
                        <?php if ($current_user['id'] !== $data['id_user']):?>
                            <a href="/server/verification?id=<?php echo $data['id'];?>" class="btn btn-outline-secondary btn-sm">Это Вы?</a>
                        <?php endif;?>
                    <?php endif;?>
                </div>
            </div>

            <div class="sv-fill">
                <div class="sv-fill-head">
                    <span><i class="fa fa-users"></i> Игроков онлайн</span>
                    <span class="sv-fill-value"><?php echo $curPlayers;?>/<?php echo $maxPlayers;?> <b><?php echo $fillPct;?>%</b></span>
                </div>
                <div class="sv-fill-bar">
                    <div class="sv-fill-bar-inner <?php echo $fillLevel;?>" style="width: <?php echo $fillPct;?>%;"></div>
                </div>
            </div>
        </div>

        <div class="content-grid">

                <div>
                    <div class="server-info">
                        <p>Карта <span class="map"><?php echo $data['map'];?></span></p>

                        <p>
                            Добавлен в мониторинг <span class="created-at"><?php echo date("d.m.Y [H:i]", $data['date_add']);?></span>
                        </p>

                        <p>
                            Владелец
                            <span>
                            <?php if ($current_user):?>
                                <?php if ($current_user['id'] !== $data['id_user']):?>
                                    Скрыт
                                <?php else:?>
                                    <?php echo $ownerName;?>
                                <?php endif;?>
                            <?php else:?>
                                <?php echo $ownerName ?? 'Гость';?>
                            <?php endif;?>
                            </span>
                        </p>

                        <?php if(!empty($data['description'])):?>
                            <p>Описание <span><?php  echo $data['description'];?></span></p>
                        <?php endif;?>

                        <hr>

                        <h3>Платные услуги</h3>

                        <?php
                        $hasServices = $data['top_enabled'] !== null || $data['vip_enabled'] !== null || $data['color_enabled'] !== null || $data['gamemenu_enabled'] !== null || $data['boost'] !== null;
                        ?>
                        <?php if ($hasServices): ?>
                        <div class="sv-services">
                            <?php if($data['top_enabled'] !== null):?>
                                <span class="sv-service-chip"><span class="ico"><i class="fa fa-arrow-up"></i></span> Топ №<?php echo $data['top_enabled'];?> <b>до <?php echo date("d.m.Y", $data['top_expired_date']);?></b></span>
                            <?php endif;?>

                            <?php if($data['vip_enabled'] !== null):?>
                                <span class="sv-service-chip"><span class="ico"><i class="fa fa-star"></i></span> VIP <b>до <?php echo date("d.m.Y", $data['vip_expired_date']);?></b></span>
                            <?php endif;?>

                            <?php if($data['color_enabled'] !== null):?>
                                <span class="sv-service-chip"><span class="ico"><i class="fa fa-paint-brush"></i></span> Цвет <b>до <?php echo date("d.m.Y", $data['color_expired_date']);?></b></span>
                            <?php endif;?>

                            <?php if($data['gamemenu_enabled'] !== null):?>
                                <span class="sv-service-chip"><span class="ico"><i class="fa fa-list"></i></span> GameMenu <b>до <?php echo date("d.m.Y", $data['gamemenu_expired_date']);?></b></span>
                            <?php endif;?>

                            <?php if($data['boost'] !== null):?>
                                <span class="sv-service-chip"><span class="ico"><i class="fa fa-bolt"></i></span> Буст <b><?php echo $data['boost'];?> кругов</b></span>
                            <?php endif;?>
                        </div>
                        <?php else: ?>
                            <p class="text-muted mb-3" style="font-size:13px;">Платные услуги не подключены</p>
                        <?php endif; ?>

                                 <a class="btn btn-primary btn-sm mt-2" href="/pay/<?php echo $data['id'];?>/select"> Заказать платную услугу</a>
                        <hr>


                        <h3>Комментарии к серверу</h3>
                        <form id="addComment" method="post">
                            <input type="hidden" name="id" value="<?php echo $data['id'];?>"/>
                            <div class="form-group">
                                <textarea class="form-control" name="comment" id="commentField" style="resize: none;" placeholder="Оставьте свой комментарий..." rows="3" maxlength="500" oninput="updateCounter()"></textarea>
                                <small id="charCounter" class="char-count">
                                    Осталось символов: 500
                                </small>
                            </div>
                            <input type="submit" class="btn btn-primary btn-sm mt-2 mb-2" value="Отправить" id="submitBtn"/>
                        </form>

                        <script>
                            function updateCounter() {
                                const textarea = document.getElementById('commentField');
                                const counter = document.getElementById('charCounter');
                                const remaining = 500 - textarea.value.length;

                                counter.textContent = `Осталось символов: ${remaining}`;

                                if (remaining < 50) {
                                    counter.style.color = remaining < 20 ? 'var(--danger)' : 'var(--warn)';
                                } else {
                                    counter.style.color = '';
                                }
                            }
                        </script>

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
                                            <?php echo $c['lastname'] ?? 'Анонимно';?>
                                        </div>
                                        <?php echo $c['text'];?>

                                        <hr/>

                                        <div class="date"><?php echo date("d.m.Y H:i", $c['date_create']);?></div>
                                    </div>
                                </div>
                            <?php endforeach;?>

                            <?php if (!empty($comments)):?>
                            <div class="pagination">
                                <nav aria-label="Pagination">
                                    <ul class="pagination justify-content-center">
                                        <?= implode("\n", $pagination_html) ?>
                                    </ul>
                                </nav>
                            </div>
                            <?php endif;?>
                        </div>

                    </div>
                </div>


                <div>
                    <div class="card map-card">
                        <h3 class="card-title">Карта сервера</h3>

                        <img class="w-100 map-shot" src="<?php echo $data['img_map'];?>" alt="<?php echo $data['map'];?>">

                        <a id="show-players-button" onclick="loadPlayers(); return false;" class="btn btn-success players-btn mt-2 btn-sm w-100">Показать игроков</a>
                    </div>
                </div>
            </div>


            <script>

                function loadPlayers(){
                    toggleButtonLoader($("#show-players-button"), true);
                    ShowModal('<?= $data['id']; ?>', 'showPlayers')
                    toggleButtonLoader($("#show-players-button"), false);
                }

                $('#addComment').ajaxForm({
                    dataType: 'json',
                    url: "/server/addcomment",
                    success: function (data) {
                        switch (data.status) {
                            case "error":
                                ShowModal(data.error, 'answer', 'error');
                                break;

                            case "success":
                                $("#commentField").val(null)
                                ShowModal(data.success, 'answer', 'success');
                                break;
                        }
                    },
                });

            </script>
        <?php endif;?>


</div>
</section>
