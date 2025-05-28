jQuery.fn.exists = function(){return this.length>0;}


$(document).ready(function () {



    function ShowModal(param, action, type) {
        $.ajax({
            url: "/modal",
            data: { 'action': action, 'param': param, 'type': type },
            type: 'post',
            success: function (data) {
                let modalId = "#" + action + "Modal";

                // Закрываем модальное окно, если оно уже существует
                if ($(modalId).exists()) {
                    $(modalId).modal('hide');
                    $(modalId).remove();
                    $("body").append(data);
                    $(modalId).modal('show');
                } else {
                    $("body").append(data);
                    $(modalId).modal('show');
                }
            }
        });
    }


    window.ShowModal = ShowModal
});


$.fn.toggleButtonLoader = function(show) {
    return this.each(function () {
        var $btn = $(this);

        if (show) {
            $btn.data('original-text', $btn.html());
            $btn.css({
                width: $btn.outerWidth(),
                height: $btn.outerHeight()
            });
            $btn.prop('disabled', true);


            $btn.html('<span class="loading">Загрузка...</span>');
            $btn.addClass('btn-spinners');
        } else {
            $btn.html($btn.data('original-text'));
            $btn.css({ width: '', height: '' });
            $btn.prop('disabled', false);
            $btn.removeClass('btn-spinners');
        }
    });
};