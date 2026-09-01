<section class="page user-promo">
    <div class="container">
        <h1 class="content-title">
            Активация промокода
        </h1>
        <hr/>

        <div class="row">

            <div class="col-md-2">
                <?php $url = "promo";
                include("UserMenu.tpl"); ?>

            </div>

            <div class="col-md-10">
                <?php echo widgets\flash\Flash::run(); ?>

                <div class="promo-card">
                    <div class="promo-icon"><i class="fa fa-ticket"></i></div>
                    <h2>Есть промокод?</h2>
                    <p>Введите код — сумма будет зачислена на баланс вашего аккаунта.</p>

                    <form method="post" action="/user/promo" class="promo-form">
                        <input
                            type="text"
                            name="code"
                            class="promo-input"
                            placeholder="Введите промокод"
                            maxlength="64"
                            autocomplete="off"
                            oninput="this.value = this.value.toUpperCase();"
                            required
                        >
                        <button type="submit" class="promo-submit">Активировать</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</section>

<style>
    .promo-card {
        background: #251e3a;
        border: 1px solid #3e3953;
        border-radius: 12px;
        padding: 36px 32px;
        max-width: 480px;
        text-align: center;
    }

    .promo-icon {
        width: 56px;
        height: 56px;
        margin: 0 auto 16px;
        border-radius: 50%;
        background: rgba(74, 113, 253, 0.15);
        color: #4a71fd;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 24px;
    }

    .promo-card h2 {
        color: #fff;
        font-size: 19px;
        margin: 0 0 8px;
    }

    .promo-card p {
        color: #a9a5bd;
        font-size: 13px;
        margin: 0 0 24px;
    }

    .promo-form {
        display: flex;
        gap: 10px;
    }

    .promo-input {
        flex: 1;
        min-width: 0;
        background: #150f24;
        border: 1px solid #3e3953;
        border-radius: 8px;
        color: #fff;
        padding: 12px 14px;
        font-family: 'Courier New', monospace;
        font-size: 15px;
        letter-spacing: 1px;
        text-align: center;
    }

    .promo-input::placeholder {
        color: #5b5670;
        font-family: inherit;
        letter-spacing: normal;
    }

    .promo-input:focus {
        outline: none;
        border-color: #4a71fd;
    }

    .promo-submit {
        flex-shrink: 0;
        background: #4a71fd;
        border: none;
        color: #fff;
        padding: 0 20px;
        border-radius: 8px;
        font-size: 14px;
        cursor: pointer;
        transition: background .15s ease;
    }

    .promo-submit:hover {
        background: #3a5ce0;
    }

    @media (max-width: 480px) {
        .promo-form {
            flex-direction: column;
        }
    }
</style>
