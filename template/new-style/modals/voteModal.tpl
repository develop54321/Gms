<div class="modal" id="voteModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Голосование за сервер - #<?php echo $data['id'];?></h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
      <div id="answer" style="text-align: center;"></div>
      <form id="" method="post">
      <input type="hidden" name="type" id="type" value="<?php echo $type;?>"/>
      
      <div class="row">
      <div class="col-md-4">
       <a href="#" id="captchaImg" onclick="updateCaptcha(); return false;">
       <img src="/main/captcha" src="Каптча"/>
       </a>
      </div>
      <div class="col-md-8">
      
       <div class="form-group">
    <label for="captcha">Цифры с картинки</label>
    <input type="text" name="captcha" class="form-control form-control-sm" id="captcha" required=""/>
    <small class="form-text text-muted">Если цифры не видны, то обновите картинку, кликнев на него.</small>
  </div>
      
      </div>
     </div> 
      
      </form>
</div>
      <div class="modal-footer">
          <a href="#" class="btn btn-primary btn-sm" onclick="voteServer(<?php echo $data['id'];?>); return false;">Голосовать</a>
          <button type="button" class="btn btn-secondary btn-sm" data-bs-dismiss="modal">Закрыть</button>
      </div>
    </div>
  </div>
</div>



<script>
function updateCaptcha(){
$("#captchaImg").html('<img src="/main/captcha" src="Каптча"/>');
}

function voteServer(id){
type = $("#type").val();
captcha = $("#captcha").val();

    $.ajax({
       url: '/server/vote',
       type: 'POST',
       dataType: 'json',
       data: {'id': id, 'type':type, 'captcha':captcha},
       success: function(data){
       switch(data.status){
        case "error":
        $("#answer").html('<span style="color: red;padding: 5px;display: block;">'+data.error+'</span>');
        break;
        
        case "success":
        $("#voteModal").modal("hide");
        ShowModal(data.success, 'answer', 'success');
        break;
       }
       },
       
    });
}
</script>