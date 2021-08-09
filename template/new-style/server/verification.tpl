<div class="content">
<nav aria-label="breadcrumb">
  <ol class="breadcrumb">
    <li class="breadcrumb-item"><a href="/">Главная</a></li>
    <li class="breadcrumb-item active" aria-current="page">Смена владельца сервера #<?php echo $data['id'];?></li>
  </ol>
</nav>

<div class="alert alert-info">
<b>Как просиходить процесс смены владельца?</b>

<ul class="list-group">
<li>1. Смените название сервера на: <code>verification<?php echo $data['verification_rand'];?></code></li>
<li>2. После чего нажмите на кнопку "Подтвердить владение серверам"."</li>
</ul>

</div>

<a href="#" onclick="verification(<?php echo $data['id'];?>); return false;" class="btn btn-primary btn-sm">Подтвердить владение сервером</a>

</div>
<script>
function verification(id){
    $.ajax({
        url: '/server/verification?id='.id,
        dataType: 'json',
         success: function(data){
                    switch(data.status){
                        case "error":
                        ShowModal(data.error, 'answer', 'error');
                        break;
                        
                        case "success":
                        ShowModal(data.success, 'answer', 'success');
                       // setTimeout('', 3000);
                        break;
                        

                    }
                },
        
    });
}
</script>