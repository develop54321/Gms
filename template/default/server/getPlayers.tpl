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