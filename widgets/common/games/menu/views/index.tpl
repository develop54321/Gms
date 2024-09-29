<div class="games-menu mb-3">
    <?php foreach ($games as $game): ?>
    <a href="/game/<?php echo $game['code'];?>" title="Игровые сервера - <?php echo $game['game'];?>"><?php echo $game['game'];?></a>
    <?php endforeach;?>
</div>