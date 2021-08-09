<div class="content">
<nav aria-label="breadcrumb">
  <ol class="breadcrumb">
    <li class="breadcrumb-item"><a href="/">Главная</a></li>
    <li class="breadcrumb-item active" aria-current="page">История платежей</li>
  </ol>
</nav>


<?php $url = "paylogs"; include("UserMenu.tpl");?>





<table class="table table table-hover m-0">
  <thead>
    <tr>
      <th scope="col">#</th>
      <th scope="col">Описание</th>
      <th scope="col">Дата инициализации</th>
      <th scope="col">Способ оплаты</th>
	  <th scope="col">Сумма</th>
      <th scope="col">Статус</th>

    </tr>
  </thead>
  <tbody>
   <?php foreach($data as $row):?>

    <tr>
      <td><?php echo $row['id'];?></td>
      <td>
      <?php if($row['type_pay'] == 'payApi'):?><b>[API]</b><?php endif;?> <?php echo $row['servicesName'];?> (<?php if($row['type_pay'] == 'refill'):?>id пользователя<?php elseif($row['type_pay'] == 'payServices' or $row['type_pay'] == 'payApi'):?>id сервера<?php endif;?> #<?php echo $row['id_object'];?>)</td>
      <td><?php echo date("d:m:Y [H:i]", $row['date_create']);?></td>
	  <td><?php if($row['pay_methods'] == 'bill'):?>Личный счёт<?php elseif($row['pay_methods'] == 'freekassa'):?>Free-Kassa<?php elseif($row['pay_methods'] == 'robokassa'):?>Robokassa<?php elseif($row['pay_methods'] == 'unitpay'):?>UnitPay<?php endif;?></td>
      <td><?php echo $row['price'];?>р.</td>
      <td>
      <?php if($row['status'] == 'expects'):?>
      <label class="badge badge-warning">Ожидает платежа</label>
      <?php elseif($row['status'] == 'paid'):?>
      <label class="badge badge-success">Оплаченный</label>
      <?php endif;?>
      </td>
    
      
    
      
  
    </tr>
    <?php endforeach;?>
    
  </tbody>
</table>




<div class="pagination">
<?php foreach($ViewPagination as $p):?>
<?php echo $p[0];?>
<?php endforeach;?>
</div>


</div>
