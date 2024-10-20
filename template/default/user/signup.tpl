<div class="content">
<nav aria-label="breadcrumb">
  <ol class="breadcrumb">
    <li class="breadcrumb-item"><a href="/">Главная</a></li>
    <li class="breadcrumb-item active" aria-current="page">Регистрация</li>
  </ol>
</nav>



<form id="signupForm" method="post">

<div class="row">
<div class="col-md-4">
<div class="form-group">
<label for="firstname">Имя</label>
<input type="text" name="firstname" id="firstname" class="form-control form-control-sm" id="inputFirstname" required="">
</div>

<div class="form-group">
<label for="lastname">Фамилия</label>
<input type="text" name="lastname" class="form-control form-control-sm" id="lastname" required="">
</div>

 <div class="form-group">
      <label for="password">Пароль</label>
      <input type="password" name="password" class="form-control form-control-sm" id="password" required="">
 </div>
    
<div class="form-group">
 <label for="password2">Повторите пароль</label>
<input type="password" name="password2" class="form-control form-control-sm" id="password2" required="">
</div>

 <div class="form-group">
      <label for="email">Электронная почта</label>
      <input type="email" name="email" class="form-control form-control-sm" id="email" required="">
    </div>


    <div class="form-group">
        <a href="#" id="captchaImg" onclick="updateCaptcha(); return false;">
            <img src="/captcha" src="Каптча"/>
        </a>
    </div>

    <div class="form-group">
        <input type="text" name="captcha" class="form-control" id="captcha" required="" placeholder="Цифры с картинки"/>
        <small class="form-text text-muted">Если цифры не видны, то обновите картинку, кликнев на него.</small>
    </div>


<div class="form-group">
      <input type="submit" class="btn btn-primary btn-sm" value="Продолжить"/>
</div>

</div>



</div>

</div>








  


  

  

  
 






  
 
</form>

 <script> 
        $(document).ready(function() { 
            $('#signupForm').ajaxForm({ 
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