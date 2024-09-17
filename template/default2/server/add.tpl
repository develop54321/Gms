<nav aria-label="breadcrumb">
    <ol class="breadcrumb">
        <li class="breadcrumb-item active" aria-current="page">Добавить сервер</li>
    </ol>
</nav>


<div class="section-add-server">
<div class="row">
<div class="col-md-4">
<form id="addServer" method="post">


  <div class="form-group">
    <label>Игра*</label>
    <select class="form-control" name="game">
    <?php foreach($games as $row):?>
    <option value="<?php echo $row['code'];?>"><?php echo $row['game'];?></option>
    <?php endforeach;?>
    
    </select>

</div>



    <div class="form-group mt-2">
    <label>Ип*</label>
    <input type="text" class="form-control" name="ip" id="formGroupExampleInput">
  </div>




    <div class="form-group mt-2">
    <label>Порт*</label>
    <input type="text" class="form-control" name="port" id="formGroupExampleInput2">
  </div>


  <div class="form-group mt-2">
    <label>Описание*</label>
    <textarea class="form-control" name="text"></textarea>

  </div>
  

  <div class="form-group mt-2">
    <button class="btn btn-primary" type="submit">Отправить</button>
     <button class="btn btn-outline-secondary" type="reset" title="Сбросить форму">
         <i class="fa fa-eraser"></i>
     </button>
  </div>
 
 
</form>
</div>

<div class="col-md-8">

<div class="alert alert-warning">
<div><p><strong>Для добавления сервера в мониторинг, он должен удовлетворять следующим правилам:</strong></p>
<ul>
<li>Работать 24/7.</li>
<li>Иметь более по одному администратору на каждые 5 слотов сервера.</li>
<li>Не загружать в клиент игры файлы форматов «.exe .cmd .jar .vbs .bat .com .dll» и подобного рода.</li>
<li>Запрещено прописывать игрокам автоматическое соединение с сервером.&nbsp;</li>
<li>Запрещён автоматический переход игроков на другие сервера.</li>
<li><span style="line-height: 1.3em;">Запрещено изменять &nbsp;«userconfig.cfg», «autoexec.cfg».</span></li>
<li>Запрещено редактировать более трех пунктов меню игры (game menu) у пользователей.</li>
<li>Не рекомендуется изменять «config.cfg» (кроме дополнительных клавиш для игры),</li>
<li> Запрещено использование команды ostrog </li>
</ul>
<p><strong>При невыполнении одного или более правил, сервер не будет отображаться в мониторинге.</strong></p>
</div>
</div>
</div>

</div>
  </div>




<script>
$('#addServer').ajaxForm({
   dataType: 'json',
   success: function(data) {
     switch(data.status){
        case "error":
        ShowModal(data.error, 'answer', 'error');
        break;
        
        case "success":
        ShowModal(data.success, 'answer', 'success');
        break;
     }
   },                          
}); 
</script>
