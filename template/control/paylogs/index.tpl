<div class="row">
<div class="col-sm-12">
<h4 class="page-title">Логи платежей</h4>
<ol class="breadcrumb">
<li><a href="/control">Главная</a></li>
<li class="active">Логи платежей</li>
</ol>
</div>
</div>


<div class="col-sm-12">
<div class="card-box">
<h4 class="m-t-0 header-title"><b>Фильтр</b> <i class="fa fa-filter"></i></h4>


<form action="/control/paylogs/search" method="get">
<div class="row">

<div class="col-md-3">
<div class="form-group">
<label>Тип платежа</label>
<select name="typePay" class="form-control input-sm">
<option value="">--Не выбрана--</option>
<option value="refill" <?php if($typePay == 'refill'):?> selected=""<?php endif;?>>Пополнение баланса</option>
<option value="payServices" <?php if($typePay == 'payServices'):?> selected=""<?php endif;?>>Оплата услуг</option>
<option value="payApi" <?php if($typePay == 'payApi'):?> selected=""<?php endif;?>>API</option>
</select>
</div>
</div>

<div class="col-md-3">
<div class="form-group">
<label>Статус</label>
<select name="statusPay" class="form-control input-sm">
<option value="">--Не выбрана--</option>
<option value="paid" <?php if($statusPay == 'paid'):?> selected=""<?php endif;?>>Оплаченный</option>
<option value="expects" <?php if($statusPay == 'expects'):?> selected=""<?php endif;?>>Ожидает платежа</option>
</select>
</div>
</div>

<div class="col-md-3">
<div class="form-group">
<label>Способ оплаты</label>
<select name="methodPay" class="form-control input-sm">
<option value="">--Не выбрана--</option>
<option value="bill" <?php if($methodPay == 'bill'):?> selected=""<?php endif;?>>Внутренней счет</option>
<?php foreach($PayMethods as $p):?>
<option value="<?php echo $p['typeCode'];?>" <?php if($methodPay == $p['typeCode']):?> selected=""<?php endif;?>><?php echo $p['name'];?></option>
<?php endforeach;?>
</select>
</div>
</div>

<div class="col-md-3">
<div class="form-group">
<label>Пользователь(Email)</label>
<input type="text" name="userPay" class="form-control input-sm" value="<?php echo $userPay;?>"/>
</div>
</div>

</div>


<div class="row">
<div class="col-md-3">
<div class="form-group">
<label>Дата(с числа)</label>
<input type="date" name="dateStart" class="form-control input-sm" value="<?php echo $filter['dateStart'];?>"/>
</div>
</div>

<div class="col-md-3">
<div class="form-group">
<label>Дата(до числа)</label>
<input type="date" name="dateEnd" class="form-control input-sm" value="<?php echo $filter['dateEnd'];?>"/>
</div>
</div>

</div>

<button type="submit" class="btn btn-primary waves-effect waves-light btn-sm">
Найти
</button>








</form>
</div>


<div class="card-box">
<h4 class="m-t-0 header-title"><b>Логи платежей</b></h4>
<p class="text-muted m-b-30 font-12">по умолчанию сортируется по дате</p>

<div class="filter">
<h4 class="m-t-0 header-title"><b>Логи платежей</b></h4>
</div>



<table class="table table table-hover m-0">
  <thead>
    <tr>
      <th scope="col">#</th>
      <th scope="col">Описание</th>
      <th scope="col">Дата инициализация</th>
      <th scope="col">Способ оплаты</th>
      <th scope="col">Сумма</th>
      <th scope="col">Статус</th>

    </tr>
  </thead>
  <tbody>
   <?php foreach($data as $row):?>

    <tr>
      <td><?php echo $row['id'];?></td>
      <td><?php echo $row['servicesName'];?>| 
      <?php if($row['type_pay'] == 'refill'):?>пользователь #<?php elseif($row['type_pay'] == 'payServices'):?>сервер #<?php endif;?><?php echo $row['id_object'];?>

      <?php if($row['type_pay'] == 'payServices' && $row['id_user'] != 0):?>
      | пользователь #<?php echo $row['id_user'];?>
      <?php endif;?>
      
       </td>
      <td><?php echo date("d:m:Y [H:i]", $row['date_create']);?></td>
      <td>
      <?php echo $row['payMethods'];?></td>
      <td><?php echo $row['price'];?>р.</td>
      <td>
        <?php widgets\user\paylogs\status\Status::run($row['status']);?>
      </td>
    
      
    
      
  
    </tr>
    <?php endforeach;?>
    
  </tbody>
</table>

<?php if(!isset($action)):?>
<div class="pagination">
<?php foreach($ViewPagination as $p):?>
<?php echo $p[0];?>
<?php endforeach;?>
</div>
<?php endif;?>



</div>
</div>
