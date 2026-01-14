jQuery.fn.exists = function(){return this.length>0;}


$(document).ready(function () {



    function ShowModal(param, action, type) {

        // Показываем прелоадер
        $("#modalPreloader").removeClass("d-none");

        // Небольшая задержка (например 300мс)
        setTimeout(function () {

            $.ajax({
                url: "/modal",
                data: { action, param, type },
                type: "post",
                success: function (data) {
                    let modalId = "#" + action + "Modal";

                    if ($(modalId).length) {
                        $(modalId).modal("hide");
                        $(modalId).remove();
                    }

                    $("body").append(data);
                    $(modalId).modal("show");
                },
                complete: function () {
                    // Скрываем прелоадер
                    $("#modalPreloader").addClass("d-none");
                }
            });

        }, 300);
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