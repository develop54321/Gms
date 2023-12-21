<div class="row">
<div class="col-sm-12">
<h4 class="page-title">Изменение страницы</h4>
<ol class="breadcrumb">
<li><a href="/control">Главная</a></li>
<li><a href="/control/pages">Страницы</a></li>
<li class="active">Изменение страницы</li>
</ol>
</div>
</div>

<div class="col-sm-12">
<div class="card-box">
<h4 class="m-t-0 header-title"><b>Изменение страницы</b></h4>


<form action="#" id="pagesForm" method="post">




<div class="form-group">
<label for="moderation">Заголовок</label>
<input type="text" name="title" class="form-control" value="<?=$data['title'];?>"/>
</div>
 

<div class="form-group">
<label for="rating">Текст</label>
<textarea name="text" class="form-control" rows="12"><?=$data['text'];?></textarea>
</div>

<div class="form-group text-right m-b-0">
<button class="btn btn-warning waves-effect waves-light" type="submit">
Изменить
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
