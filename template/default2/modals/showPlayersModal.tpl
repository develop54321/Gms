<div class="modal" id="showPlayersModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Список игроков</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
          <?php if (in_array($game, ['cs', 'csgo', 'css', 'tf2', 'ld2', 'rust', 'csgo2'])):?>
              <table class="table table-dark">
                  <thead>
                  <tr>
                      <th>Ник</th>
                      <th>Фраги</th>
                      <th>Время</th>
                  </tr>
                  </thead>
                  <?php foreach($players as $row):?>
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
                  <?php foreach($players as $row):?>
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
                  <?php foreach($players as $row):?>
                      <tr>
                          <td><?php echo $row['name'];?></td>
                          <td><?php echo $row['score'];?></td>
                          <td><?php echo $row['ping'];?></td>
                      </tr>
                  <?php endforeach;?>
              </table>
          <?php endif;?>

      </div>
      <div class="modal-footer">
          <button type="button" class="btn btn-outline-danger btn-sm" data-bs-dismiss="modal">Закрыть</button>
      </div>
    </div>
  </div>
</div>
