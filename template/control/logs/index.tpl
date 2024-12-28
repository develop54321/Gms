<div class="row">
<div class="col-sm-12">
<h4 class="page-title">Логи</h4>
<ol class="breadcrumb">
<li><a href="/control">Главная</a></li>
<li class="active">Логи</li>
</ol>
</div>
</div>


<div class="col-sm-12">

<div class="card-box">
<h4 class="m-t-0 header-title"><b>Логи</b></h4>
<p class="text-muted m-b-30 font-12">по умолчанию сортируется по дате</p>


    <a href="/control/logs/clear" style="float: right;" onclick="return confirm('Вы действительно хотите очистить логи?');" class="btn btn-danger btn-custom btn-rounded waves-effect waves-light btn-xs"> <i class="fa fa-trash"></i> Очистить</a>



<table class="table table table-hover m-0">
  <thead>
    <tr>
      <th scope="col">#</th>
      <th scope="col">Описание</th>
      <th scope="col">Дата инициализация</th>
    </tr>
  </thead>
  <tbody>
   <?php foreach($data as $row):?>

    <tr>
      <td><?php echo $row['id'];?></td>
      <td><?php echo $row['text'];?></td>
      <td><?php echo date("d:m:Y [H:i]", $row['date_create']);?></td>
    </tr>
    <?php endforeach;?>
    
  </tbody>
</table>

    <div class="pagination">
        <nav aria-label="Pagination">
            <ul class="pagination justify-content-center">
                <?= implode("\n", $pagination_html) ?>
            </ul>
        </nav>
    </div>


</div>
</div>
