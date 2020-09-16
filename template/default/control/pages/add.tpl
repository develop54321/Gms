<div class="row">
<div class="col-sm-12">
<h4 class="page-title">Добавление страницы</h4>
<ol class="breadcrumb">
<li><a href="/control">Главная</a></li>
<li><a href="/control/pages">Страницы</a></li>
<li class="active">Добавление страницы</li>
</ol>
</div>
</div>

<div class="col-sm-12">
<div class="card-box">
<h4 class="m-t-0 header-title"><b>Добавление страницы</b></h4>


<form action="#" id="pagesForm" method="post">




<div class="form-group">
<label for="moderation">Заголовок</label>
<input type="text" name="title" class="form-control"/>
</div>
 

<div class="form-group">
<label for="rating">Текст</label>
<textarea name="text" class="form-control"></textarea>
</div>

<div class="form-group text-right m-b-0">
<button class="btn btn-primary waves-effect waves-light" type="submit">
Добавить
</button>


</div>
</div>



</form>




										

        				                        				


</div>
<script>
$('#pagesForm').ajaxForm({
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
