<section class="page server-banners">
    <div class="container">
        <div class="banners-header">
            <div>
                <h1 class="content-title">
                    Баннеры сервера - <?php echo \widgets\server\hostname\Hostname::run($data['hostname']);?>
                </h1>
                <p class="banners-subtitle">
                    Выберите вариант и скопируйте код в подпись на форуме или на свой сайт — онлайн и статус обновляются автоматически.
                </p>
            </div>
            <a href="/server/<?php echo $data['ip'];?>:<?php echo $data['port'];?>/info" class="btn-back">&larr; Назад к серверу</a>
        </div>

        <?php if (!empty($banners['horizontal'])):?>
            <h2 class="banners-group-title">Горизонтальные <span>для подписи и шапки форума</span></h2>
            <div class="banners-grid">
                <?php foreach ($banners['horizontal'] as $banner):?>
                    <?php include ROOT_DIR . 'template/dark/server/_banner_card.tpl';?>
                <?php endforeach;?>
            </div>
        <?php endif;?>

        <?php if (!empty($banners['vertical'])):?>
            <h2 class="banners-group-title">Вертикальные <span>для сайдбара сайта</span></h2>
            <div class="banners-grid">
                <?php foreach ($banners['vertical'] as $banner):?>
                    <?php include ROOT_DIR . 'template/dark/server/_banner_card.tpl';?>
                <?php endforeach;?>
            </div>
        <?php endif;?>
    </div>
</section>

<style>
    .banners-header {
        display: flex;
        justify-content: space-between;
        align-items: flex-start;
        flex-wrap: wrap;
        gap: 16px;
        margin-bottom: 20px;
    }

    .banners-subtitle {
        color: var(--text-dim);
        max-width: 600px;
        margin: 4px 0 0;
        font-size: 13px;
        line-height: 1.5;
    }

    .btn-back {
        display: inline-block;
        padding: 7px 14px;
        border-radius: 6px;
        background: var(--surface-2);
        color: #fff;
        text-decoration: none;
        font-size: 13px;
        white-space: nowrap;
        transition: background .15s ease;
    }

    .btn-back:hover {
        background: var(--border);
        color: #fff;
    }

    .banners-group-title {
        font-size: 13px;
        text-transform: uppercase;
        letter-spacing: .04em;
        color: #fff;
        display: flex;
        align-items: baseline;
        gap: 8px;
        margin: 24px 0 12px;
        padding-bottom: 8px;
        border-bottom: 1px solid var(--border);
    }

    .banners-group-title:first-of-type {
        margin-top: 0;
    }

    .banners-group-title span {
        text-transform: none;
        font-size: 12px;
        font-weight: 400;
        letter-spacing: normal;
        color: var(--text-faint);
    }

    .banners-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(260px, 1fr));
        align-items: start;
        gap: 14px;
    }

    .banner-card {
        position: relative;
        background: var(--surface);
        border: 1px solid var(--border);
        border-radius: 8px;
        padding: 12px;
        transition: border-color .15s ease;
    }

    .banner-card:hover {
        border-color: var(--accent);
    }

    .banner-card-badge {
        position: absolute;
        top: -8px;
        right: 12px;
        background: var(--accent);
        color: #fff;
        font-size: 10px;
        font-weight: 600;
        padding: 2px 8px;
        border-radius: 10px;
        letter-spacing: .02em;
    }

    .banner-card-head {
        display: flex;
        justify-content: space-between;
        align-items: baseline;
        margin-bottom: 8px;
    }

    .banner-card-head h3 {
        font-size: 14px;
        margin: 0;
        color: #fff;
    }

    .banner-size {
        font-size: 11px;
        color: var(--text-faint);
        white-space: nowrap;
    }

    .banner-preview {
        display: flex;
        align-items: center;
        justify-content: center;
        min-height: 70px;
        background: var(--surface-3);
        border-radius: 6px;
        padding: 10px;
        margin-bottom: 10px;
    }

    .banner-preview img {
        max-width: 100%;
        height: auto;
        border-radius: 4px;
    }

    .embed-row {
        display: flex;
        align-items: center;
        gap: 6px;
        background: var(--bg);
        border: 1px solid var(--border);
        border-radius: 6px;
        padding: 4px;
    }

    .embed-tabs {
        display: flex;
        flex-shrink: 0;
        background: var(--surface-3);
        border-radius: 5px;
        padding: 2px;
        gap: 2px;
    }

    .embed-tab {
        border: none;
        background: transparent;
        color: var(--text-faint);
        font-size: 11px;
        padding: 4px 8px;
        border-radius: 4px;
        cursor: pointer;
        transition: background .15s ease, color .15s ease;
    }

    .embed-tab:hover {
        color: var(--text);
    }

    .embed-tab.is-active {
        background: var(--accent);
        color: #fff;
    }

    .embed-field {
        display: flex;
        align-items: center;
        flex: 1;
        min-width: 0;
        gap: 4px;
    }

    .embed-input {
        flex: 1;
        min-width: 0;
        border: none;
        background: transparent;
        color: var(--text);
        font-family: 'Courier New', monospace;
        font-size: 11px;
        padding: 4px 2px;
        text-overflow: ellipsis;
    }

    .embed-input:focus {
        outline: none;
    }

    .embed-copy {
        flex-shrink: 0;
        display: flex;
        align-items: center;
        justify-content: center;
        width: 26px;
        height: 26px;
        border: none;
        border-radius: 5px;
        background: var(--surface-2);
        color: var(--text);
        cursor: pointer;
        transition: background .15s ease, color .15s ease;
    }

    .embed-copy:hover {
        background: var(--accent);
        color: #fff;
    }

    .embed-copy.copied {
        background: var(--mint);
        color: #fff;
    }
</style>
