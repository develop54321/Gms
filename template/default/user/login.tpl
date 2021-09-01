<div class="content">
<nav aria-label="breadcrumb">
  <ol class="breadcrumb">
    <li class="breadcrumb-item"><a href="/">Главная</a></li>
    <li class="breadcrumb-item active" aria-current="page">Авторизация</li>
  </ol>
</nav>


<form id="loginForm" method="post">
<div class="row">
<div class="col-md-4">

  <div class="form-group">
    <label for="email">Электронная почта</label>
    <input type="email" name="email" class="form-control form-control-sm" id="email" placeholder="Электронная почта">
  </div>
  <div class="form-group">
    <label for="password">Пароль</label>
    <input type="password" name="password" class="form-control form-control-sm" id="password" placeholder="Пароль">
  </div>
  
  

    </div>
      </div>
      <div class="form-group">
<input type="submit" class="btn btn-primary btn-sm" value="Войти"/>
<a href="/user/signup" class="btn btn-info btn-sm">Регистрация</a>
<a href="/user/reset" class="btn btn-info btn-sm">Забыли пароль?</a>
  </div>
      
</form>
</div>

<script> 
        $(document).ready(function() { 
            $('#loginForm').ajaxForm({ 
                dataType: "json",
                success: function(data){
                    switch(data.status){
                        case "error":
                        ShowModal(data.error, 'answer', 'error');
                        break;
                        
                        case "success":
                        ShowModal(data.success, 'answer', 'success');
                          setTimeout('location.replace("/user")', 2000);
                        break;
                        

                    }
                },
            }); 
        }); 
</script>