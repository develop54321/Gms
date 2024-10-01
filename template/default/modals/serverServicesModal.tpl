<div class="modal fade" id="serverServicesModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Услуги сервера - #<?php echo $data['id'];?></h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
      <p>

<li><?php if($data['top_enabled'] != '0'):?>
TOP - место #<?php echo $data['top_enabled'];?> | истекает: <?php echo date("d-m-Y H:i", $data['top_expired_date']);?>
<?php else:?>
TOP: <a href="/user/serverpay?id=<?php echo $data['id'];?>">Купить</a>
<?php endif;?>
</li>
<li>
<?php if($data['boost'] != '0'):?>
Boost: осталось кругов: <?php echo $data['boost'];?> <a href="/user/serverpay?id=<?php echo $data['id'];?>">Купить</a>
<?php else:?>
Boost: <a href="/user/serverpay?id=<?php echo $data['id'];?>">Купить</a>
<?php endif;?>
</li>
<li><?php if($data['vip_enabled'] != '0'):?>
VIP: истекает: <?php echo date("d-m-Y H:i", $data['vip_expired_date']);?>
<?php else:?>
VIP: <a href="/user/serverpay?id=<?php echo $data['id'];?>">Купить</a>
<?php endif;?>
</li>
<li><?php if($data['color_enabled'] != '0'):?>
Выделение цветом: истекает: <?php echo date("d-m-Y H:i", $data['color_expired_date']);?>
<?php else:?>
Выделение цветом: <a href="/user/serverpay?id=<?php echo $data['id'];?>">Купить</a>
<?php endif;?>
</li>
<li><?php if($data['gamemenu_enabled'] != '0'):?>
GameMenu: истекает: <?php echo date("d-m-Y H:i", $data['gamemenu_expired_date']);?>
<?php else:?>
GameMenu: <a href="/user/serverpay?id=<?php echo $data['id'];?>">Купить</a>
<?php endif;?>
</li>

      
      </p>
</div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary btn-sm" data-dismiss="modal">Закрыть</button>
      </div>
    </div>
  </div>
</div>