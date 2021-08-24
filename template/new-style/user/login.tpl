<section class="content mt-5">
  <div class="container">
  <nav aria-label="breadcrumb">
  <ol class="breadcrumb">
    <li class="breadcrumb-item"><a href="/">Главная</a></li>
    <li class="breadcrumb-item active" aria-current="page">Авторизация</li>
  </ol>
</nav>


<form id="loginForm" method="post">
<div class="row">
  <div class="col-md-5">


  <div class="mb-3">
    <label for="email">Электронная почта</label>
    <input type="email" name="email" class="form-control form-control-sm" id="email" placeholder="Электронная почта">
  </div>
  <div class="mb-3">
    <label for="password">Пароль</label>
    <input type="password" name="password" class="form-control form-control-sm" id="password" placeholder="Пароль">
  </div>

  <div class="mb-3">
<input type="submit" class="btn btn-outline-success" value="Войти"/>
<a href="/user/signup" class="btn btn-outline-primary">Регистрация</a>
<a href="/user/reset" class="btn btn-outline-primary">Забыли пароль?</a>
  </div>
      
</form>
</div>
  </div>
  </div>
</section>

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
                        setTimeout('document.location.replace("/user")', 3000);
                        break;
                        

                    }
                },
            }); 
        }); 
</script>