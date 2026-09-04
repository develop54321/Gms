jQuery.fn.exists = function () {
    return this.length > 0;
}


$(document).ready(function () {
    function ShowModal(param, action, type) {

        $("#modalPreloader").removeClass("d-none");


        setTimeout(function () {

            $.ajax({
                url: "/modal",
                data: {action, param, type},
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
                    $("#modalPreloader").addClass("d-none");
                }
            });

        }, 300);
    }


    window.ShowModal = ShowModal
});


$.fn.toggleButtonLoader = function (show) {
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
            $btn.css({width: '', height: ''});
            $btn.prop('disabled', false);
            $btn.removeClass('btn-spinners');
        }
    });
};

function toggleButtonLoader(button, isLoading) {
    if (isLoading) {
        $(button).prop('disabled', true).addClass('btn-loader').append('<span class="loader"></span>');
    } else {
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





function copyToClipboard(elementId) {
    const text = document.getElementById(elementId).innerText;
    navigator.clipboard.writeText(text).then(() => {
        alert('IP адрес скопирован: ' + text);
    }).catch(err => {
        console.error('Ошибка копирования: ', err);
    });
}

window.copyToClipboard = copyToClipboard

function switchEmbedTab(btn, type) {
    const row = btn.closest('.embed-row');
    row.querySelectorAll('.embed-tab').forEach(tab => tab.classList.remove('is-active'));
    btn.classList.add('is-active');
    row.querySelector('.embed-input').value = row.querySelector('.embed-input').dataset[type];
}

function copyEmbedInput(btn) {
    const input = btn.closest('.embed-field').querySelector('.embed-input');
    input.select();
    navigator.clipboard.writeText(input.value).then(() => {
        const originalHtml = btn.innerHTML;
        btn.innerHTML = '<i class="fa fa-check"></i>';
        btn.classList.add('copied');
        clearTimeout(btn._copyResetTimeout);
        btn._copyResetTimeout = setTimeout(() => {
            btn.innerHTML = originalHtml;
            btn.classList.remove('copied');
        }, 1200);
    }).catch(err => {
        console.error('Ошибка копирования: ', err);
    });
}

window.switchEmbedTab = switchEmbedTab
window.copyEmbedInput = copyEmbedInput


$(document).ready(function () {
    const $input = $('#headerSearchInput');
    if (!$input.exists()) return;

    const $results = $('#headerSearchResults');
    let debounceTimer = null;
    let requestToken = 0;
    let activeIndex = -1;

    function openResults() {
        $results.addClass('is-open');
    }

    function closeResults() {
        $results.removeClass('is-open');
        activeIndex = -1;
    }

    function setActive(index) {
        const $items = $results.find('.search-result-item');
        if (!$items.length) return;

        activeIndex = ((index % $items.length) + $items.length) % $items.length;
        $items.removeClass('is-active').eq(activeIndex).addClass('is-active');
    }

    function runSearch(query) {
        const token = ++requestToken;

        $results.html('<div class="search-results-loading"><i class="fa fa-spinner fa-spin"></i> Поиск...</div>');
        openResults();

        $.ajax({
            url: '/search/live',
            data: {query: query},
            dataType: 'html',
            success: function (html) {
                if (token !== requestToken) return;
                activeIndex = -1;
                $results.html(html);
                openResults();
            },
            error: function () {
                if (token !== requestToken) return;
                closeResults();
            }
        });
    }

    $input.on('input', function () {
        const query = $input.val().trim();

        clearTimeout(debounceTimer);

        if (query.length < 2) {
            closeResults();
            return;
        }

        debounceTimer = setTimeout(function () {
            runSearch(query);
        }, 300);
    });

    $input.on('keydown', function (e) {
        if (!$results.hasClass('is-open')) return;
        const $items = $results.find('.search-result-item');
        if (!$items.length) return;

        if (e.key === 'ArrowDown') {
            e.preventDefault();
            setActive(activeIndex + 1);
        } else if (e.key === 'ArrowUp') {
            e.preventDefault();
            setActive(activeIndex - 1);
        } else if (e.key === 'Enter') {
            if (activeIndex >= 0) {
                e.preventDefault();
                window.location.href = $items.eq(activeIndex).attr('href');
            }
        } else if (e.key === 'Escape') {
            closeResults();
        }
    });

    $input.on('focus', function () {
        if ($input.val().trim().length >= 2 && $results.children().length) {
            openResults();
        }
    });

    $(document).on('click', function (e) {
        if (!$(e.target).closest('.search-wrap').length) {
            closeResults();
        }
    });
});