<div class="page-header">
    <div>
        <h1 class="page-title">Панель управления</h1>
    </div>
</div>

<div class="row row-deck">
    <div class="col-md-6">
        <div class="card">
            <div class="card-status card-status-left bg-primary br-bl-7 br-tl-7"></div>
            <div class="card-header border-bottom">
                <h3 class="card-title">Информация о системе</h3>
            </div>
            <div class="card-body">
                <table class="table  border text-nowrap text-md-nowrap">
                    <tbody>
                    <tr>
                        <td>
                            Версия php: <?php echo phpversion(); ?>
                        </td>
                    </tr>

                    <tr>
                        <td>Версия mysql: <?php echo $versionMysql; ?></td>
                    </tr>

                    <tr>
                        <td>Размер базы данных: <?php echo $sizeDatabase; ?> мб.</td>
                    </tr>

                    <tr>
                        <td>Время на сервере: <?php echo date("d:m:Y H:i"); ?></td>
                    </tr>

                    <tr>
                        <td>Последняя проверка серверов: <?php echo time() - $settings['last_update_servers']; ?> сек.</td>
                    </tr>

                    <tr>
                        <td>
                            Текущая версия: <?php echo $version; ?>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </div>

    </div>

    <div class="col-md-6">


        <div class="card">
            <div class="card-status card-status-left bg-red br-bl-7 br-tl-7"></div>
            <div class="card-header border-bottom">
                <h3 class="card-title">Уведомление</h3>
            </div>
            <div class="card-body">




                <?php if (empty($notification)): ?>
                    Новых уведомлений нету
                <?php else: ?>

                    <table class="table  border text-nowrap text-md-nowrap">
                        <tbody>

                        <?php foreach ($notification as $n): ?>
                            <?php if ($n['type'] == 'moderationServers' && $n['count'] !== 0): ?>
                                <tr>
                                    <td>
                                        Серверов ожидают проверку: <?php echo $n['count']; ?>
                                    </td>
                                </tr>

                            <?php elseif ($n['type'] == 'moderationComments' && $n['count'] !== 0): ?>
                                <tr>
                                    <td>
                                        Комментариев ожидающую проверку: <?php echo $n['count']; ?>
                                    </td>
                                </tr>
                            <?php endif; ?>
                        <?php endforeach; ?>

                        </tbody>
                    </table>
                <?php endif; ?>

            </div>
        </div>
    </div>


</div>






<div class="row row-deck">
    <div class="col-md-6">

        <div class="card">
            <div class="card-status card-status-left bg-primary br-bl-7 br-tl-7"></div>
            <div class="card-header border-bottom">
                <h3 class="card-title">Статистика</h3>
            </div>
            <div class="card-body">

                <table class="table  border text-nowrap text-md-nowrap">
                    <tbody>

                    <tr>
                        <td>
                            Всего серверов: <?php echo $countServers; ?> <br/>
                            Сегодня: <?php echo $countServersToday;?><br/>
                            За последнюю неделю: <?php echo $countServersLastWeek;?><br/>
                            За текущих месяц: <?php echo $countServersThisMonth;?><br/>
                        </td>
                    </tr>


                    <tr>
                        <td>
                            Всего активных серверов: <?php echo $countActiveServers; ?>
                        </td>
                    </tr>


                    <tr>
                        <td>
                            Всего зарегистрированных пользователей: <?php echo $countUsers; ?> <br/>
                            Сегодня: <?php echo $countUsersToday;?><br/>
                            За последнюю неделю: <?php echo $countUsersLastWeek;?><br/>
                            За текущих месяц: <?php echo $countUsersThisMonth;?><br/>

                        </td>
                    </tr>

                    <tr>
                        <td>
                            Всего комментариев: <?php echo $countComments; ?>
                        </td>
                    </tr>



                    </tbody>
                </table>

            </div>
        </div>
    </div>

    <div class="col-md-6">

        <div class="card">
            <div class="card-status card-status-left bg-primary br-bl-7 br-tl-7"></div>
            <div class="card-header border-bottom">
                <h3 class="card-title">Статистика по платежам</h3>
            </div>
            <div class="card-body">

                <table class="table  border text-nowrap text-md-nowrap">
                    <tbody>

                    <tr>
                        <td>
                            Доход за сегодня: <?php echo \widgets\money\Money::run($incomeToday);?><br/>
                            За последнюю неделю: <?php echo \widgets\money\Money::run($incomeWeek);?><br/>
                            За текущих месяц: <?php echo \widgets\money\Money::run($incomeMonth);?><br/>
                        </td>
                    </tr>


                    </tbody>
                </table>

            </div>
        </div>
    </div>
</div>