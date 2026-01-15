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



function toggleButtonLoader(button, isLoading) {
    if (isLoading) {
        // Показываем загрузчик сразу
        $(button).prop('disabled', true).addClass('btn-loader').append('<span class="loader"></span>');
    } else {
        // Добавляем небольшую задержку перед скрытием (300ms)
        setTimeout(() => {
            $(button).prop('disabled', false).removeClass('btn-loader').find('.loader').remove();
        }, 300);
    }
}

window.toggleButtonLoader = toggleButtonLoader


document.addEventListener("DOMContentLoaded", function () {
    const cookieBanner = document.getElementById("cookieBanner");
    const acceptBtn = document.getElementById("acceptCookies");

    if (!localStorage.getItem("cookiesAccepted")) {
        cookieBanner.style.display = "block";
    }

    acceptBtn.addEventListener("click", function () {
        localStorage.setItem("cookiesAccepted", "true");
        cookieBanner.style.display = "none";
    });
});