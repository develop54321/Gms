jQuery.fn.exists = function(){return this.length>0;}



function ShowModal(param, action, type){
    $.ajax({
        url: "/control/modal",
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
