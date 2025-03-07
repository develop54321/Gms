
"use strict";

(function ($) {

    // PAGE LOADING
    $(window).on("load", function (e) {
        $("#global-loader").fadeOut("slow");
    })

    //COLOR THEME
    $(document).on("click", "a[data-theme]", function () {
        $("head link#theme").attr("href", $(this).data("theme"));
        $(this).toggleClass('active').siblings().removeClass('active');
    });

    // FAQ ACCORDION
    $(document).on("click", '[data-bs-toggle="collapse"]', function () {
        $(this).toggleClass('active').siblings().removeClass('active');
    });

    // FULL SCREEN
    $(document).on("click", ".full-screen-link", function toggleFullScreen() {
        $('.full-screen-link').addClass('fullscreen-button');
        if ((document.fullScreenElement !== undefined && document.fullScreenElement === null) || (document.msFullscreenElement !== undefined && document.msFullscreenElement === null) || (document.mozFullScreen !== undefined && !document.mozFullScreen) || (document.webkitIsFullScreen !== undefined && !document.webkitIsFullScreen)) {
            if (document.documentElement.requestFullScreen) {
                document.documentElement.requestFullScreen();
            } else if (document.documentElement.mozRequestFullScreen) {
                document.documentElement.mozRequestFullScreen();
            } else if (document.documentElement.webkitRequestFullScreen) {
                document.documentElement.webkitRequestFullScreen(Element.ALLOW_KEYBOARD_INPUT);
            } else if (document.documentElement.msRequestFullscreen) {
                document.documentElement.msRequestFullscreen();
            }
        } else {
            $('html').removeClass('fullscreen-button');
            if (document.cancelFullScreen) {
                document.cancelFullScreen();
            } else if (document.mozCancelFullScreen) {
                document.mozCancelFullScreen();
            } else if (document.webkitCancelFullScreen) {
                document.webkitCancelFullScreen();
            } else if (document.msExitFullscreen) {
                document.msExitFullscreen();
            }
        }
    })

    //  ITEM NOTES
    $('.thumb').on('click', function () {
        if (!$(this).hasClass('active')) {
            $(".thumb.active").removeClass("active");
            $(this).addClass("active");
        }
    });

    // TOGGLE SWITCHES
    $('.toggle').on('click', function () {
        $(this).toggleClass('on');
    })

    // BACK TO TOP BUTTON
    $(window).on("scroll", function (e) {
        if ($(this).scrollTop() > 0) {
            $('#back-to-top').fadeIn('slow');
        } else {
            $('#back-to-top').fadeOut('slow');
        }
    });
    $(document).on("click", "#back-to-top", function (e) {
        $("html, body").animate({
            scrollTop: 0
        }, 0);
        return false;
    });


    // COVER IMAGE
    $(".cover-image").each(function () {
        var attr = $(this).attr('data-bs-image-src');
        if (typeof attr !== typeof undefined && attr !== false) {
            $(this).css('background', 'url(' + attr + ') center center');
        }
    });

    // QUANTITY CART INCREASE AND DECREASE
    $('.add').on('click', function () {
        var $qty = $(this).closest('div').find('.qty');
        var currentVal = parseInt($qty.val());
        if (!isNaN(currentVal)) {
            $qty.val(currentVal + 1);
        }
    });
    $('.minus').on('click', function () {
        var $qty = $(this).closest('div').find('.qty');
        var currentVal = parseInt($qty.val());
        if (!isNaN(currentVal) && currentVal > 0) {
            $qty.val(currentVal - 1);
        }
    });

    // CHART CIRCLE
    if ($('.chart-circle').length) {
        $('.chart-circle').each(function () {
            let $this = $(this);
            $this.circleProgress({
                fill: {
                    color: $this.attr('data-bs-color')
                },
                size: $this.height(),
                startAngle: -Math.PI / 4 * 2,
                emptyFill: '#edf0f5',
                lineCap: 'round'
            });
        });
    }

    // MODAL
    // SHOWING MODAL WITH EFFECT
    $('.modal-effect').on('click', function (e) {
        e.preventDefault();
        var effect = $(this).attr('data-bs-effect');
        $('#modaldemo8').addClass(effect);
    });

    // HIDE MODAL WITH EFFECT
    $('#modaldemo8').on('hidden.bs.modal', function (e) {
        $(this).removeClass(function (index, className) {
            return (className.match(/(^|\s)effect-\S+/g) || []).join(' ');
        });
    });

    // CARD
    const DIV_CARD = 'div.card';

    // TOOLTIP
    var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
    var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
        return new bootstrap.Tooltip(tooltipTriggerEl)
    })

    // POPOVER
    var popoverTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="popover"]'))
    var popoverList = popoverTriggerList.map(function (popoverTriggerEl) {
        return new bootstrap.Popover(popoverTriggerEl)
    })
    $(document).on('click', function (e) {
        $('[data-toggle="popover"],[data-original-title]').each(function () {
            //the 'is' for buttons that trigger popups
            //the 'has' for icons within a button that triggers a popup
            if (!$(this).is(e.target) && $(this).has(e.target).length === 0 && $('.popover').has(e.target).length === 0) {
                (($(this).popover('hide').data('bs.popover') || {}).inState || {}).click = false // fix for BS 3.3.6
            }

        });
    });

    // TOAST
    var toastElList = [].slice.call(document.querySelectorAll('.toast'))
    var toastList = toastElList.map(function (toastEl) {
        return new bootstrap.Toast(toastEl)
    })
    $("#liveToastBtn").on('click', function () {
        $('.toast').toast('show');
    })

    // OFFCANVAS
    var offcanvasElementList = [].slice.call(document.querySelectorAll('.offcanvas'))
    var offcanvasList = offcanvasElementList.map(function (offcanvasEl) {
        return new bootstrap.Offcanvas(offcanvasEl)
    })

    // FUNCTION FOR REMOVE CARD
    $(document).on('click', '[data-bs-toggle="card-remove"]', function (e) {
        let $card = $(this).closest(DIV_CARD);
        $card.remove();
        e.preventDefault();
        return false;
    });


    // FUNCTIONS FOR COLLAPSED CARD
    $(document).on('click', '[data-bs-toggle="card-collapse"]', function (e) {
        let $card = $(this).closest(DIV_CARD);
        $card.toggleClass('card-collapsed');
        e.preventDefault();
        return false;
    });

    // CARD FULL SCREEN
    $(document).on('click', '[data-bs-toggle="card-fullscreen"]', function (e) {
        let $card = $(this).closest(DIV_CARD);
        $card.toggleClass('card-fullscreen').removeClass('card-collapsed');
        e.preventDefault();
        return false;
    });


    // INPUT FILE BROWSER
    $(document).on('change', '.file-browserinput', function () {
        var input = $(this),
            numFiles = input.get(0).files ? input.get(0).files.length : 1,
            label = input.val().replace(/\\/g, '/').replace(/.*\//, '');
        input.trigger('fileselect', [numFiles, label]);
    }); // We can watch for our custom `fileselect` event like this

    // FILE UPLOAD
    $('.file-browserinput').on('fileselect', function (event, numFiles, label) {
        var input = $(this).parents('.input-group').find(':text'),
            log = numFiles > 1 ? numFiles + ' files selected' : label;
        if (input.length) {
            input.val(log);
        } else {
            if (log) alert(log);
        }
    });


    // SWITCHER-TOGGLE

    $('.layout-setting').on("click", function (e) {
        if (document.querySelector('body').classList.contains('dark-mode')) {
            $('body').removeClass('dark-mode');
            $('body').removeClass('bg-img1');
            $('body').removeClass('bg-img2');
            $('body').removeClass('bg-img3');
            $('body').removeClass('bg-img4');
            $('body').addClass('light-mode');

			localStorage.setItem('lightMode', true);
			localStorage.removeItem('darkMode');
        }
        else {
            $('body').addClass('dark-mode');
            $('body').removeClass('light-mode');
            $('body').removeClass('bg-img1');
            $('body').removeClass('bg-img2');
            $('body').removeClass('bg-img3');
            $('body').removeClass('bg-img4');

            localStorage.setItem('darkMode', true);
			localStorage.removeItem('lightMode');
        }
    });

//######## SWITCHER STYLES ######## //

// -------- Sidemenu layout Styles -------- //

    // ICON OVERLAY SIDEMENU START
        // $('body').addClass('icon-overlay');
        // $('body').addClass('sidenav-toggled');
        // if((document.querySelector('body').classList.contains('login-img')) ){
        //     return;
        // }       
        // else if((document.querySelector('body').classList.contains('error-bg'))){
        //     return;
        // }
        // else{
        //     hovermenu();
        // }
    // ICON OVERLAY SIDEMENU END

    // ICONTEXT SIDEMENU START
        // $('body').addClass('icontext-menu');
        // $('body').addClass('sidenav-toggled');
        // if((document.querySelector('body').classList.contains('login-img')) ){
        //     return;
        // }       
        // else if((document.querySelector('body').classList.contains('error-bg'))){
        //     return;
        // }
        // else{
        //     icontext();
        // }
    // ICONTEXT SIDEMENU END

    // CLOSED SIDEMENU START
        // $('body').addClass('closed-leftmenu');
        // $('body').addClass('sidenav-toggled');
    // CLOSED SIDEMENU END

    // HOVER SUBMENU START
        // $('body').addClass('hover-submenu');
        // $('body').addClass('sidenav-toggled');
        // if((document.querySelector('body').classList.contains('login-img')) ){
        //     return;
        // }       
        // else if((document.querySelector('body').classList.contains('error-bg'))){
        //     return;
        // }
        // else{
        //     hovermenu();
        // }
    // HOVER SUBMENU END

    // HOVER SUBMENU STYLE-1 START
        // $('body').addClass('hover-submenu1');
        // $('body').addClass('sidenav-toggled');
        // if((document.querySelector('body').classList.contains('login-img')) ){
        //     return;
        // }       
        // else if((document.querySelector('body').classList.contains('error-bg'))){
        //     return;
        // }
        // else{
        //     hovermenu();
        // }
    // HOVER SUBMENU STYLE-1 END

// ----- ! Sidemenu layout Styles ------- //  


// HEADER POSITION STYLES START
    // $('body').addClass('scrollable-layout');
// HEADER POSITION STYLES END

// ----- Layout Styles ------- // 

    // BOXED LAYOUT START
        // $('body').addClass('layout-boxed');
    // BOXED LAYOUT END

// ----- ! Layout Styles ------- // 


// ----- Header Styles ------- //

    // LIGHT HEADER START
        // $('body').addClass('header-light');
    // LIGHT HEADER END

    // COLOR HEADER START
        // $('body').addClass('color-header');
    // COLOR HEADER END

    // DARK HEADER START
        // $('body').addClass('dark-header');
    // DARK HEADER END

    // GRADIENT HEADER START
        // $('body').addClass('gradient-header');
    // GRADIENT HEADER END

// ----- ! Header Styles ------- //  

// ----- Menu Styles ------- //

    // LIGHT LEFTMENU START
        // $('body').addClass('light-menu');
    // LIGHT LEFTMENU END

    // COLOR LEFTMENU START
        // $('body').addClass('color-menu');
    // COLOR LEFTMENU END

    // DARK LEFTMENU START
        // $('body').addClass('dark-menu');
    // DARK LEFTMENU END

    // GRADIENT LEFTMENU START
        // $('body').addClass('gradient-menu');
    // GRADIENT LEFTMENU END

// ----- ! Menu Styles ------- //


// ----- Dark Theme Style ------- //

    // DARK THEME START
        // $('body').addClass('dark-mode');
    // DARK THEME END

// ----- ! Dark Theme Styles ------- //

// ----- Background Image Styles ------- //

    // Bg-Image1 Style Start
        // $('body').addClass('bg-img1');
        // $('body').addClass('dark-mode');
    // ! Bg-Image1 Style End

    // Bg-Image2 Style Start
        // $('body').addClass('bg-img2');
        // $('body').addClass('dark-mode');
    // ! Bg-Image1 Style End

    // Bg-Image3 Style Start
        // $('body').addClass('bg-img3');
        // $('body').addClass('dark-mode');
    // ! Bg-Image2 Style End

    // Bg-Image4 Style Start
        // $('body').addClass('bg-img4');
        // $('body').addClass('dark-mode');
    // ! Bg-Image4 Style End

// ----- ! Background Image Styles ------- //

// ----- RTL Style ------- //

// $('body').addClass('rtl');


let bodyRtl = $('body').hasClass('rtl');
if (bodyRtl) {
    $('body').addClass('rtl');

    $('#slide-left').removeClass('d-none');
    $('#slide-right').removeClass('d-none');
    $("html[lang=en]").attr("dir", "rtl");
    $('body').removeClass('ltr');
    $("head link#style").attr("href", $(this));
    (document.getElementById("style").setAttribute("href", "../assets/plugins/bootstrap/css/bootstrap.rtl.min.css"));
    var carousel = $('.owl-carousel');
    $.each(carousel, function (index, element) {
        // element == this
        var carouselData = $(element).data('owl.carousel');
        carouselData.settings.rtl = true; //don't know if both are necessary
        carouselData.options.rtl = true;
        $(element).trigger('refresh.owl.carousel');
    });

    if (!document.querySelector('body').classList.contains('login-img') && !document.querySelector('body').classList.contains('error-bg')) {
        checkHoriMenu();
    }
}


// ! ----- RTL Style ------- //

// ----- Horizontal Style ------- //

// $('body').addClass('horizontal');

let bodyhorizontal = $('body').hasClass('horizontal');
    if (bodyhorizontal) {
        $('body').addClass('horizontal');
        $(".main-content").addClass("hor-content");
        $(".main-content").removeClass("app-content");
        $(".main-container").addClass("container");
        $(".main-container").removeClass("container-fluid");
        $(".app-header").addClass("hor-header");
        $(".hor-header").removeClass("app-header");
        $(".app-sidebar").addClass("horizontal-main")
        $(".main-sidemenu").addClass("container")
        $('body').removeClass('sidebar-mini');
        $('body').removeClass('sidenav-toggled');
        $('body').removeClass('horizontal-hover');
        $('body').removeClass('default-menu');
        $('body').removeClass('icontext-menu');
        $('body').removeClass('icon-overlay');
        $('body').removeClass('closed-leftmenu');
        $('body').removeClass('hover-submenu');
        $('body').removeClass('hover-submenu1');
        localStorage.setItem("horizantal", "True");
        // To enable no-wrap horizontal style
        $('#slide-left').removeClass('d-none');
        $('#slide-right').removeClass('d-none');
        // To enable wrap horizontal style
        // $('#slide-left').addClass('d-none');
        // $('#slide-right').addClass('d-none');
        // document.querySelector('.horizontal .side-menu').style.flexWrap = 'wrap'
       
        if (!document.querySelector('body').classList.contains('login-img') && !document.querySelector('body').classList.contains('error-bg')) {
            checkHoriMenu();
            responsive();
            document.querySelector('.horizontal .side-menu').style.flexWrap = 'nowrap'
        }
        if (window.innerWidth >= 992) {
            let li = document.querySelectorAll('.side-menu li')
            li.forEach((e, i) => {
                e.classList.remove('is-expanded')
            })
            var animationSpeed = 300;
            // first level
            var parent = $("[data-bs-toggle='sub-slide']").parents('ul');
            var ul = parent.find('ul:visible').slideUp(animationSpeed);
            ul.removeClass('open');
            var parent1 = $("[data-bs-toggle='sub-slide2']").parents('ul');
            var ul1 = parent1.find('ul:visible').slideUp(animationSpeed);
            ul1.removeClass('open');
        }
    }

// ----- Horizontal Style ------- //

// ----- Horizontal Hover Style ------- //
// $('body').addClass('horizontal-hover');

let bodyhorizontal1 = $('body').hasClass('horizontal-hover');
    if (bodyhorizontal1) {
        $('body').addClass('horizontal-hover');
        $('body').addClass('horizontal');
        $(".main-content").addClass("hor-content");
        $(".main-content").removeClass("app-content");
        $(".main-container").addClass("container");
        $(".main-container").removeClass("container-fluid");
        $(".app-header").addClass("hor-header");
        $(".app-header").removeClass("app-header");
        $(".app-sidebar").addClass("horizontal-main")
        $(".main-sidemenu").addClass("container")
        $('body').removeClass('sidebar-mini');
        $('body').removeClass('sidenav-toggled');
        $('body').removeClass('default-menu');
        $('body').removeClass('icontext-menu');
        $('body').removeClass('icon-overlay');
        $('body').removeClass('closed-leftmenu');
        $('body').removeClass('hover-submenu');
        $('body').removeClass('hover-submenu1');
        // To enable no-wrap horizontal style
        $('#slide-left').addClass('d-none');
        $('#slide-right').addClass('d-none');
        // To enable wrap horizontal style
        // $('#slide-left').addClass('d-none');
        // $('#slide-right').addClass('d-none');
        // document.querySelector('.horizontal .side-menu').style.flexWrap = 'wrap'
        if (!document.querySelector('body').classList.contains('login-img') && !document.querySelector('body').classList.contains('error-bg')) {
            document.querySelector('.horizontal .side-menu').style.flexWrap = 'nowrap'
            checkHoriMenu();
            responsive();
        }
        if( window.innerWidth >= 992 ) {
            let li = document.querySelectorAll('.side-menu li')
        li.forEach((e, i) => {
            e.classList.remove('is-expanded')
        })
        var animationSpeed = 300;
        // first level
        var parent = $("[data-bs-toggle='sub-slide']").parents('ul');
        var ul = parent.find('ul:visible').slideUp(animationSpeed);
        ul.removeClass('open');
        var parent1 = $("[data-bs-toggle='sub-slide2']").parents('ul');
        var ul1 = parent1.find('ul:visible').slideUp(animationSpeed);
        ul1.removeClass('open');
        }
    }

// ----- Horizontal Hover Style ------- //


    

    // ACCORDION STYLE
    $(document).on("click", '[data-bs-toggle="collapse"]', function () {
        $(this).toggleClass('active').siblings().removeClass('active');
    });

    // EMAIL INBOX
    $(".clickable-row").on('click', function () {
        window.location = $(this).data("href");
    });
    

})(jQuery);


// OFF-CANVAS STYLE
$('.off-canvas').on('click', function () {
    $('body').addClass('overflow-y-scroll');
    $('body').addClass('pe-0');
});