
'use strict';

(function () {

    var stickyElement = $(".sticky"),
        stickyClass = "sticky-pin",
        stickyPos = 75, //Distance from the top of the window.
        stickyHeight;



    ///Create a negative margin to prevent content 'jumps':
    stickyElement.after('<div class="jumps-prevent"></div>');

    function jumpsPrevent() {
        stickyHeight = 74;
        stickyElement.css({ "margin-bottom": "-" + stickyHeight + "px" });
        stickyElement.next().css({ "padding-top": +stickyHeight + "px" });
    };
    jumpsPrevent(); //Run.

    //Function trigger:
    $(window).resize(function () {
        jumpsPrevent();
    });

    //Sticker function:
    function stickerFn() {
        var winTop = $(this).scrollTop();
        //Check element position:
        winTop >= stickyPos ?
            stickyElement.addClass('stickyClass') :
            stickyElement.removeClass('stickyClass') //Boolean class switcher.
    };
    stickerFn(); //Run.
    $(window).scroll(function () {
        stickerFn();
    });

    // sidemenu
    $('.app-sidebar').on("scroll",function () {
        var s = $(".app-sidebar .ps__rail-y");
        if (s[0].style.top.split('px')[0] <= 60) {
            $('.app-sidebar').removeClass('sidemenu-scroll')
        } else {
            $('.app-sidebar').addClass('sidemenu-scroll')
        }

    })
    $('.app-sidebar').on("scroll",function () {
        var s = $(".app-sidebar .ps__rail-y");
        if (s[0].style.top.split('px')[0] <= 60) {
            $('.app-header').removeClass('res-scroll')
        } else {
            $('.app-header').addClass('res-scroll')
        }

    })

})();
