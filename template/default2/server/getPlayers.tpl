<?php if (in_array($game, ['cs', 'csgo', 'css', 'tf2', 'ld2', 'rust'])):?>
<table class="table">
<thead>
<tr>
<th>Ник</th>
<th>Фраги</th>
<th>Время</th>
</tr>
</thead>
<?php foreach($data as $row):?>
<tr>
<td><?php echo $row['Name'];?></td>
<td><?php echo $row['Frags'];?></td>
<td><?php echo $row['TimeF'];?></td>
</tr>
<?php endforeach;?>
</table>
<?php elseif($game == 'samp'):?>
<table class="table">
    <thead>
    <tr>
        <th>Ник</th>
        <th>Фраги</th>
        <th>Пинг</th>
    </tr>
    </thead>
    <?php foreach($data as $row):?>
    <tr>
        <td><?php echo $row['name'];?></td>
        <td><?php echo $row['score'];?></td>
        <td><?php echo $row['ping'];?></td>
    </tr>
    <?php endforeach;?>
</table>
<?php elseif($game == 'mta'):?>
<table class="table">
    <thead>
    <tr>
        <th>Ник</th>
        <th>Фраги</th>
        <th>Пинг</th>
    </tr>
    </thead>
    <?php foreach($data as $row):?>
    <tr>
        <td><?php echo $row['name'];?></td>
        <td><?php echo $row['score'];?></td>
        <td><?php echo $row['ping'];?></td>
    </tr>
    <?php endforeach;?>
</table>
<?php endif;?>