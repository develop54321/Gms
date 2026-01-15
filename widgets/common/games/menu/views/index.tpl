<div class="games-menu mb-3">
    <?php foreach ($games as $game): ?>

    <?php if ($game['code'] === $currentGameCode):?>
        <a href="/game/<?php echo $game['code'];?>" class="active" title="Игровые сервера - <?php echo $game['game'];?>"><?php echo $game['game'];?></a>
    <?php else:?>
        <a href="/game/<?php echo $game['code'];?>" title="Игровые сервера - <?php echo $game['game'];?>"><?php echo $game['game'];?></a>
    <?php endif;?>

    <?php endforeach;?>
</div>