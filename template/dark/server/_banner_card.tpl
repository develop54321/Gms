<div class="banner-card">
    <?php if ($banner['recommended']):?>
        <span class="banner-card-badge">Рекомендуем</span>
    <?php endif;?>

    <div class="banner-card-head">
        <h3><?php echo $banner['label'];?></h3>
        <span class="banner-size"><?php echo $banner['width'];?>&times;<?php echo $banner['height'];?></span>
    </div>

    <div class="banner-preview">
        <img src="<?php echo $banner['url'];?>" width="<?php echo $banner['width'];?>" height="<?php echo $banner['height'];?>" alt="<?php echo htmlspecialchars($banner['label']);?>">
    </div>

    <div class="embed-row">
        <div class="embed-tabs">
            <button type="button" class="embed-tab is-active" onclick="switchEmbedTab(this, 'bbcode')">BBCode</button>
            <button type="button" class="embed-tab" onclick="switchEmbedTab(this, 'html')">HTML</button>
        </div>
        <div class="embed-field">
            <input
                type="text"
                class="embed-input"
                readonly
                onclick="this.select();"
                data-bbcode="<?php echo htmlspecialchars($banner['bbcode']);?>"
                data-html="<?php echo htmlspecialchars($banner['html']);?>"
                value="<?php echo htmlspecialchars($banner['bbcode']);?>"
            >
            <button type="button" class="embed-copy" title="Скопировать" onclick="copyEmbedInput(this)">
                <i class="fa fa-copy"></i>
            </button>
        </div>
    </div>
</div>
