jQuery.fn.exists = function(){return this.length>0;}





function ShowModal(param, action, type){
    $.ajax({
       url: "/modal",
       data: {'action':action, 'param':param, 'type':type},
       type: 'post',
       success: function(data){
         if($("#"+action+"Modal").exists()) {
             $("#"+action+"Modal").remove();
             $("body").append(data);
         }else{
             $("body").append(data);
         }
         $("#"+action+"Modal").modal('show');
       },
    });
} 


function votePlus(id){
    $.ajax({
       url: "/main/voteplus",
       type: "post",
       dataType: "json",
       data: {'id':id}, 
       success: function(data){
        switch(data.status){
        case "error":
        ShowModal(data.error, 'answer', 'error');
        break;
        
        case "success":
        $("#vote"+id).text(data.rating);
        ShowModal(data.success, 'answer', 'success');
        break;
     }
       },
       error: function(e) {alert(e)}
    });
}

function voteMinus(id){
    $.ajax({
       url: "/main/voteminus",
       type: "post",
       dataType: "json",
       data: {'id':id}, 
       success: function(data){
        switch(data.status){
        case "error":
        ShowModal(data.error, 'answer', 'error');
        break;
        
        case "success":
        $("#vote"+id).text(data.rating);
        ShowModal(data.success, 'answer', 'success');
        break;
     }
       },
       error: function(e) {alert(e)}
    });
}
