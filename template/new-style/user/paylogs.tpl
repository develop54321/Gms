<section class="content mt-5">
  <div class="container">
<nav aria-label="breadcrumb">
  <ol class="breadcrumb">
    <li class="breadcrumb-item"><a href="/">Главная</a></li>
    <li class="breadcrumb-item active" aria-current="page">История платежей</li>
  </ol>
</nav>




    <div class="row">

      <div class="col-md-2">
        <?php $url = "paylogs"; include("UserMenu.tpl");?>

      </div>


      <div class="col-md-10">
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
      <td><?php echo \widgets\money\Money::run($row['price']);?></td>
      <td>
        <?php widgets\user\paylogs\status\Status::run($row['status']);?>
      </td>
    
      
    
      
  
    </tr>
    <?php endforeach;?>
    
  </tbody>
</table>
        <div class="pagination mt-2">
          <?php foreach($ViewPagination as $p):?>
          <?php echo $p[0];?>
          <?php endforeach;?>
        </div>
      </div>





  </div>
  </div>
</section>