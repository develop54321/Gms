<section class="page">
    <div class="container">
        <h1 class="content-title">
            Пополнение счета
        </h1>
        <hr/>


        <div class="row">

            <div class="col-md-2">
                <?php $url = "pay";
                include("UserMenu.tpl"); ?>

            </div>

            <div class="col-md-10">


                <?php echo widgets\flash\Flash::run(); ?>
                <?php if ($step == '1'): ?>
                    <div class="row">
                        <div class="col-md-4">
                            <form action="#" method="post">
                                <div class="mb-3">
                                    <label>Выберите способ оплаты</label>
                                    <select class="form-control" name="typePayment">
                                        <?php foreach ($PayMethods as $pm): ?>
                                            <option value="<?php echo $pm['id']; ?>"><?php echo $pm['name']; ?></option>
                                        <?php endforeach; ?>
                                    </select>
                                </div>
                                <div class="mb-3">
                                    <input type="number" name="amout" class="form-control" required="">
                                </div>
                                <button type="submit" class="btn btn-primary">Далее</button>
                            </form>

                        </div>
                    </div>


                <?php elseif ($step == '2'): ?>
                    <?php
                    $desc = "Пополнение счета  #" . $user_profile['id'] . "";
                    if ($InfoPayment['typeCode'] == 'robokassa') {
                        $crc = md5("" . $InfoPayment['login'] . ":" . $amount . ":$payId:" . $InfoPayment['password1'] . "");
                    } elseif ($InfoPayment['typeCode'] == 'freekassa') {
                        $signfk = md5($InfoPayment['fk_id'].':'.$amount.':'.$InfoPayment['fk_key1'].':RUB:'.$payId);
                    } elseif ($InfoPayment['typeCode'] == 'unitpay') {
                        $hashStr = $payId . '{up}' . $desc . '{up}' . $amount . '{up}' . $InfoPayment['secret_key'];
                        $hash = hash('sha256', $hashStr);
                    }

                    $price = $amount;
                    ?>
                    <?php include(TMPL_DIR . "/pay/" . $InfoPayment['typeCode'] . ".tpl"); ?>

                <?php endif; ?>
            </div>
        </div>
    </div>
</section>