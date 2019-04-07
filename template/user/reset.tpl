<div class="content">
<nav aria-label="breadcrumb">
  <ol class="breadcrumb">
    <li class="breadcrumb-item"><a href="/">Главная</a></li>
    <li class="breadcrumb-item active" aria-current="page">Восстановления пароля</li>
  </ol>
</nav>

<?php if(isset($password)):?>
<p>
Ваш новый пароль: <code><?php echo $password;?></code>
</p>
<?php else:?>
<form id="resetForm" method="post">
<div class="row">
<div class="col-md-4">

  <div class="form-group">
    <label for="email">Электронная почта</label>
    <input type="email" name="email" class="form-control form-control-sm" id="email">
  </div>
    
    </div>
      </div>
      <div class="form-group">
<input type="submit" class="btn btn-primary btn-sm" value="Отправить"/>
  </div>
      
</form>
</div>

<script> 
        $(document).ready(function() { 
            $('#resetForm').ajaxForm({ 
                dataType: "json",
                success: function(data){
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
        }); 
</script>
<?php endif;?>