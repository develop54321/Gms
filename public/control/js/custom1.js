
"use strict";

(function ($) {
    // ______________ Page Loading
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

            localStorage.clear()
            localStorage.setItem('noalightMode', true);
        }
        else {
            $('body').addClass('dark-mode');
            $('body').removeClass('light-mode');
            $('body').removeClass('bg-img1');
            $('body').removeClass('bg-img2');
            $('body').removeClass('bg-img3');
            $('body').removeClass('bg-img4');
            localStorage.clear()
            localStorage.setItem('noadarkMode', true);
        }
    });

    // LIGHT THEME START
    $(document).on("click", '#myonoffswitch1', function () {
        if (this.checked) {
            $('body').removeClass('dark-mode');
            $('body').addClass('light-mode');
            $('#myonoffswitch3').prop('checked', true);
            $('#myonoffswitch6').prop('checked', true);
            localStorage.setItem('noalightMode', true);
            localStorage.removeItem('noadarkMode');

            // remove dark theme properties	
            localStorage.removeItem('noadarkPrimary')

            // remove light theme properties
            localStorage.removeItem('noaprimaryColor')
            localStorage.removeItem('noaprimaryHoverColor')
            localStorage.removeItem('noaprimaryBorderColor')
            document.querySelector('html').style.removeProperty('--primary-bg-color', localStorage.darkPrimary);
            document.querySelector('html').style.removeProperty('--primary-bg-hover', localStorage.darkPrimary);
            document.querySelector('html').style.removeProperty('--primary-bg-border', localStorage.darkPrimary);
            document.querySelector('html').style.removeProperty('--dark-primary', localStorage.darkPrimary);

            // removing dark theme properties
            localStorage.removeItem('noadarkPrimary')
            localStorage.removeItem('noaBgImage')
            localStorage.removeItem('noadarkBackgroundColor');
            if ($('body').hasClass('bg-img1') || $('body').hasClass('bg-img2') || $('body').hasClass('bg-img3') || $('body').hasClass('bg-img4')) {
                $('body').removeClass('bg-img1')
                $('body').removeClass('bg-img2')
                $('body').removeClass('bg-img3')
                $('body').removeClass('bg-img4')
            }
            $('#myonoffswitch1').prop('checked', true);

            checkOptions();
            const root = document.querySelector(':root');
            root.style = "";
            names()
        }
        // localStorageBackup();
    });
    // LIGHT THEME END

    // DARK THEME START
    $(document).on("click", '#myonoffswitch2', function () {
        if (this.checked) {
            $('body').addClass('dark-mode');

            $('#myonoffswitch5').prop('checked', true);
            $('#myonoffswitch8').prop('checked', true);
            localStorage.setItem('noadarkMode', true);
            localStorage.removeItem('noalightMode');
            $('body').removeClass('light-mode');
            if ($('body').hasClass('bg-img1') || $('body').hasClass('bg-img2') || $('body').hasClass('bg-img3') || $('body').hasClass('bg-img4')) {
                $('body').removeClass('bg-img1')
                $('body').removeClass('bg-img2')
                $('body').removeClass('bg-img3')
                $('body').removeClass('bg-img4')
            }

            // remove light theme properties
            localStorage.removeItem('noaprimaryColor')
            localStorage.removeItem('noaprimaryHoverColor')
            localStorage.removeItem('noaprimaryBorderColor')
            localStorage.removeItem('noadarkPrimary')
            localStorage.removeItem('noadarkBackgroundColor')
            document.querySelector('html').style.removeProperty('--primary-bg-color', localStorage.darkPrimary);
            document.querySelector('html').style.removeProperty('--primary-bg-hover', localStorage.darkPrimary);
            document.querySelector('html').style.removeProperty('--primary-bg-border', localStorage.darkPrimary);
            document.querySelector('html').style.removeProperty('--dark-primary', localStorage.darkPrimary);

            // removing light theme data 
            localStorage.removeItem('noaBgImage');

            $('#myonoffswitch2').prop('checked', true);
            $('#myonoffswitchTransparent').prop('checked', false);
            //
            checkOptions();

            const root = document.querySelector(':root');
            root.style = "";
            names()
        }
    });
    // DARK THEME END

    // BACKGROUND IMAGE STYLE START
    $(document).on("click", '#bgimage1', function () {
        $('body').addClass('bg-img1');
        $('body').removeClass('bg-img2');
        $('body').removeClass('bg-img3');
        $('body').removeClass('bg-img4');

        $('body').removeClass('light-menu');
        $('body').removeClass('color-menu');
        $('body').removeClass('dark-menu');
        $('body').removeClass('gradient-menu');
        $('body').removeClass('header-light');
        $('body').removeClass('color-header');
        $('body').removeClass('dark-header');
        $('body').removeClass('gradient-header');

        document.querySelector('body').classList.remove('light-mode');
        document.querySelector('body').classList.add('dark-mode');

        $('#myonoffswitch2').prop('checked', true);
        $('#myonoffswitch1').prop('checked', false);
        localStorage.removeItem('noalightMode');

        checkOptions();
    })

    $(document).on("click", '#bgimage2', function () {
        $('body').addClass('bg-img2');
        $('body').removeClass('bg-img1');
        $('body').removeClass('bg-img3');
        $('body').removeClass('bg-img4');

        $('body').removeClass('light-menu');
        $('body').removeClass('color-menu');
        $('body').removeClass('dark-menu');
        $('body').removeClass('gradient-menu');
        $('body').removeClass('header-light');
        $('body').removeClass('color-header');
        $('body').removeClass('dark-header');
        $('body').removeClass('gradient-header');

        document.querySelector('body').classList.remove('light-mode');
        document.querySelector('body').classList.add('dark-mode');

        $('#myonoffswitch2').prop('checked', true);
        $('#myonoffswitch1').prop('checked', false);
        localStorage.removeItem('noalightMode');

        checkOptions();
    })

    $(document).on("click", '#bgimage3', function () {
        $('body').addClass('bg-img3');
        $('body').removeClass('bg-img1');
        $('body').removeClass('bg-img2');
        $('body').removeClass('bg-img4');

        $('body').removeClass('light-menu');
        $('body').removeClass('color-menu');
        $('body').removeClass('dark-menu');
        $('body').removeClass('gradient-menu');
        $('body').removeClass('header-light');
        $('body').removeClass('color-header');
        $('body').removeClass('dark-header');
        $('body').removeClass('gradient-header');

        document.querySelector('body').classList.remove('light-mode');
        document.querySelector('body').classList.add('dark-mode');

        $('#myonoffswitch2').prop('checked', true);
        $('#myonoffswitch1').prop('checked', false);
        localStorage.removeItem('noalightMode');

        checkOptions();
    })

    $(document).on("click", '#bgimage4', function () {
        $('body').addClass('bg-img4');
        $('body').removeClass('bg-img1');
        $('body').removeClass('bg-img2');
        $('body').removeClass('bg-img3');


        $('body').removeClass('light-menu');
        $('body').removeClass('color-menu');
        $('body').removeClass('dark-menu');
        $('body').removeClass('gradient-menu');
        $('body').removeClass('header-light');
        $('body').removeClass('color-header');
        $('body').removeClass('dark-header');
        $('body').removeClass('gradient-header');
        localStorage.removeItem('noalightMode');

        document.querySelector('body').classList.remove('light-mode');
        document.querySelector('body').classList.add('dark-mode');
        $('#myonoffswitch2').prop('checked', true);
        $('#myonoffswitch1').prop('checked', false);

        checkOptions();
    })
    // BACKGROUND IMAGE STYLE END

    // LIGHT LEFTMENU START
    $(document).on("click", '#myonoffswitch3', function () {
        if (this.checked) {
            $('body').addClass('light-menu');
            $('body').removeClass('color-menu');
            $('body').removeClass('dark-menu');
            $('body').removeClass('gradient-menu');
        } else {
            $('body').removeClass('light-menu');
        }
    });
    // LIGHT LEFTMENU END

    // COLOR LEFTMENU START
    $(document).on("click", '#myonoffswitch4', function () {
        if (this.checked) {
            $('body').addClass('color-menu');
            $('body').removeClass('light-menu');
            $('body').removeClass('dark-menu');
            $('body').removeClass('gradient-menu');
        } else {
            $('body').removeClass('color-menu');
        }
    });
    // COLOR LEFTMENU END

    // DARK LEFTMENU START
    $(document).on("click", '#myonoffswitch5', function () {
        if (this.checked) {
            $('body').addClass('dark-menu');
            $('body').removeClass('color-menu');
            $('body').removeClass('light-menu');
            $('body').removeClass('gradient-menu');
        } else {
            $('body').removeClass('dark-menu');
        }
    });
    // DARK LEFTMENU END

    // GRADIENT LEFTMENU START
    $(document).on("click", '#myonoffswitch19', function () {
        if (this.checked) {
            $('body').addClass('gradient-menu');
            $('body').removeClass('color-menu');
            $('body').removeClass('light-menu');
            $('body').removeClass('dark-menu');
        } else {
            $('body').removeClass('gradient-menu');
        }
    });
    // GRADIENT LEFTMENU END

    // LIGHT HEADER START
    $(document).on("click", '#myonoffswitch6', function () {
        if (this.checked) {
            $('body').addClass('header-light');
            $('body').removeClass('color-header');
            $('body').removeClass('dark-header');
            $('body').removeClass('gradient-header');
        } else {
            $('body').removeClass('header-light');
        }
    });
    // LIGHT HEADER END

    // COLOR HEADER START
    $(document).on("click", '#myonoffswitch7', function () {
        if (this.checked) {
            $('body').addClass('color-header');
            $('body').removeClass('header-light');
            $('body').removeClass('dark-header');
            $('body').removeClass('gradient-header');
        } else {
            $('body').removeClass('color-header');
        }
    });
    // COLOR HEADER END

    // DARK HEADER START
    $(document).on("click", '#myonoffswitch8', function () {
        if (this.checked) {
            $('body').addClass('dark-header');
            $('body').removeClass('color-header');
            $('body').removeClass('header-light');
            $('body').removeClass('gradient-header');
        } else {
            $('body').removeClass('dark-header');
        }
    });
    // DARK HEADER END

    // GRADIENT HEADER START
    $(document).on("click", '#myonoffswitch20', function () {
        if (this.checked) {
            $('body').addClass('gradient-header');
            $('body').removeClass('color-header');
            $('body').removeClass('header-light');
            $('body').removeClass('dark-header');
        } else {
            $('body').removeClass('gradient-header');
        }
    });
    // GRADIENT HEADER END

    // FULL WIDTH LAYOUT START
    $('#myonoffswitch9').on('click', function () {
        if (this.checked) {
            $('body').addClass('layout-fullwidth');
            $('body').removeClass('layout-boxed');
            checkHoriMenu();
        } else {
            $('body').removeClass('layout-fullwidth');
        }
    });
    // FULL WIDTH LAYOUT END

    // BOXED LAYOUT START
    $('#myonoffswitch10').on('click', function () {
        if (this.checked) {
            $('body').addClass('layout-boxed');
            $('body').removeClass('layout-fullwidth');
            checkHoriMenu();
        } else {
            $('body').removeClass('layout-boxed');
        }
    });
    // BOXED LAYOUT END

    // HEADER POSITION STYLES START
    $('#myonoffswitch11').on('click', function () {
        if (this.checked) {
            $('body').addClass('fixed-layout');
            $('body').removeClass('scrollable-layout');
        } else {
            $('body').removeClass('fixed-layout');
        }
    });
    $('#myonoffswitch12').on('click', function () {
        if (this.checked) {
            $('body').addClass('scrollable-layout');
            $('body').removeClass('fixed-layout');
        } else {
            $('body').removeClass('scrollable-layout');
        }
    });
    // HEADER POSITION STYLES END

    // DEFAULT SIDEMENU START
    $(document).on("click", '#myonoffswitch13', function () {
        if (this.checked) {
            $('body').addClass('default-menu');
            $('body').removeClass('sidenav-toggled');
            hovermenu();
            $('body').removeClass('icontext-menu');
            $('body').removeClass('icon-overlay');
            $('body').removeClass('closed-leftmenu');
            $('body').removeClass('hover-submenu');
            $('body').removeClass('hover-submenu1');
        } else {
            $('body').removeClass('default-menu');
        }
    });
    // DEFAULT SIDEMENU END

    // ICON OVERLAY SIDEMENU START
    $('#myonoffswitch15').on('click', function () {
        if (this.checked) {
            $('body').addClass('icon-overlay');
            hovermenu();
            $('body').addClass('sidenav-toggled');
            $('body').removeClass('hover-submenu1');
            $('body').removeClass('default-menu');
            $('body').removeClass('closed-leftmenu');
            $('body').removeClass('hover-submenu');
            $('body').removeClass('icontext-menu');
        } else {
            $('body').removeClass('icon-overlay');
            $('body').removeClass('sidenav-toggled');
        }
    });
    // ICON OVERLAY SIDEMENU END

    // ICONTEXT SIDEMENU START
    $('#myonoffswitch14').on('click', function () {
        if (this.checked) {
            $('body').addClass('icontext-menu');
            icontext();
            $('body').addClass('sidenav-toggled');
            $('body').removeClass('icon-overlay');
            $('body').removeClass('hover-submenu1');
            $('body').removeClass('default-menu');
            $('body').removeClass('closed-leftmenu');
            $('body').removeClass('hover-submenu');
        } else {
            $('body').removeClass('icontext-menu');
            $('body').removeClass('sidenav-toggled');
        }
    });
    // ICONTEXT SIDEMENU END

    // CLOSED SIDEMENU START
    $('#myonoffswitch16').on('click', function () {
        if (this.checked) {
            $('body').addClass('closed-leftmenu');
            $('body').addClass('sidenav-toggled');
            $('body').removeClass('default-menu');
            $('body').removeClass('hover-submenu1');
            $('body').removeClass('hover-submenu');
            $('body').removeClass('icon-overlay');
            $('body').removeClass('icontext-menu');

        } else {
            $('body').removeClass('closed-leftmenu');
            $('body').removeClass('sidenav-toggled');
            $('body').addClass('default-menu');
        }
    });
    // CLOSED SIDEMENU END

    // HOVER SUBMENU START
    $('#myonoffswitch17').on('click', function () {
        if (this.checked) {
            $('body').addClass('hover-submenu');
            hovermenu();
            $('body').addClass('sidenav-toggled');
            $('body').removeClass('hover-submenu1');
            $('body').removeClass('default-menu');
            $('body').removeClass('closed-leftmenu');
            $('body').removeClass('icon-overlay');
            $('body').removeClass('icontext-menu');
            $('.app-sidebar').removeClass('sidemenu-scroll');
        } else {
            $('body').removeClass('hover-submenu');
            $('body').removeClass('sidenav-toggled');
        }
    });
    // HOVER SUBMENU END

    // HOVER SUBMENU STYLE-1 START
    $('#myonoffswitch18').on('click', function () {
        if (this.checked) {
            $('body').addClass('hover-submenu1');
            hovermenu();
            $('body').addClass('sidenav-toggled');
            $('body').removeClass('hover-submenu');
            $('body').removeClass('default-menu');
            $('body').removeClass('closed-leftmenu');
            $('body').removeClass('icon-overlay');
            $('body').removeClass('icontext-menu');
            $('.app-sidebar').removeClass('sidemenu-scroll');
        } else {
            $('body').removeClass('hover-submenu1');
            $('body').removeClass('sidenav-toggled');
        }
    });
    // HOVER SUBMENU STYLE-1 END

    // ACCORDION STYLE
    $(document).on("click", '[data-bs-toggle="collapse"]', function () {
        $(this).toggleClass('active').siblings().removeClass('active');
    });

    // EMAIL INBOX
    $(".clickable-row").on('click', function () {
        window.location = $(this).data("href");
    });

    // HORIZONTAL
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
        // To enable no-wrap horizontal style
        $('#slide-left').removeClass('d-none');
        $('#slide-right').removeClass('d-none');
        // To enable wrap horizontal style
        // $('#slide-left').addClass('d-none');
        // $('#slide-right').addClass('d-none');
        // document.querySelector('.horizontal .side-menu').style.flexWrap = 'wrap'
        // menuClick();
        if (!document.querySelector('body').classList.contains('login-img') && !document.querySelector('body').classList.contains('error-bg')) {
            checkHoriMenu();
            responsive();
            sidemenudropdown();
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

    // HORIZONTAL HOVER
    function light() {
        if (document.querySelector('body').classList.contains('light-mode')) {
            $('#myonoffswitch3').prop('checked', true);
            $('#myonoffswitch6').prop('checked', true);
        }
    }
    light();
    let bodyhorizontal1 = $('body').hasClass('horizontal-hover');
    if (bodyhorizontal1) {
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
        $('body').addClass('horizontal-hover');
        $('body').addClass('horizontal');
        // $('#slide-left').addClass('d-none');
        // $('#slide-right').addClass('d-none');
        // document.querySelector('.horizontal .side-menu').style.flexWrap = 'wrap'
        $('#slide-left').addClass('d-none');
        $('#slide-right').addClass('d-none');
        document.querySelector('.horizontal .side-menu').style.flexWrap = 'nowrap'
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
        checkHoriMenu();
        responsive();

    }
    else {
    }

})(jQuery);

// OFF-CANVAS STYLE
$('.off-canvas').on('click', function () {
    $('body').addClass('overflow-y-scroll');
    $('body').addClass('pe-0');
});

// RTL STYLE START
$('#myonoffswitch24').on('click', function () {
    if (this.checked) {
        $('body').addClass('rtl');

        $('#slide-left').removeClass('d-none');
        $('#slide-right').removeClass('d-none');
        $("html[lang=en]").attr("dir", "rtl");

        $(".select2-container").attr("dir", "rtl");

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
        localStorage.setItem('noartl', true)
        localStorage.removeItem('noaltr')
        if (!document.querySelector('body').classList.contains('login-img') && !document.querySelector('body').classList.contains('error-bg')) {
            checkHoriMenu();
        }
    }
});

if ($("body").hasClass("rtl")) {
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
// RTL STYLE END

// LTR STYLE START
$('#myonoffswitch23').on('click', function () {
    if (this.checked) {
        $('body').addClass('ltr');
        
        $(".select2-container").attr("dir", "ltr");

        $('#slide-left').removeClass('d-none');
        $('#slide-right').removeClass('d-none');
        $("html[lang=en]").attr("dir", "ltr");
        $('body').removeClass('rtl');
        $("head link#style").attr("href", $(this));
        (document.getElementById("style").setAttribute("href", "../assets/plugins/bootstrap/css/bootstrap.min.css"));
        var carousel = $('.owl-carousel');
        $.each(carousel, function (index, element) {
            // element == this
            var carouselData = $(element).data('owl.carousel');
            carouselData.settings.rtl = false; //don't know if both are necessary
            carouselData.options.rtl = false;
            $(element).trigger('refresh.owl.carousel');
        });
        localStorage.setItem('noaltr', true)
        localStorage.removeItem('noartl')
        if (!document.querySelector('body').classList.contains('login-img') && !document.querySelector('body').classList.contains('error-bg')) {
            checkHoriMenu();
        }
    }
});
// LTR STYLE END

$('#myonoffswitch34').on('click', function () {
    if (this.checked) {
        sidemenudropdown();
        $('body').removeClass('horizontal');
        $('body').removeClass('horizontal-hover');
        $(".main-content").removeClass("hor-content");
        $(".main-content").addClass("app-content");
        $(".main-container").removeClass("container");
        $(".main-container").addClass("container-fluid");
        $(".app-header").removeClass("hor-header");
        $(".hor-header").addClass("app-header");
        $(".app-sidebar").removeClass("horizontal-main")
        $(".main-sidemenu").removeClass("container")
        $('#slide-left').removeClass('d-none');
        $('#slide-right').removeClass('d-none');
        $('body').addClass('sidebar-mini');
        localStorage.setItem("noasidebarMini", "true");
        localStorage.removeItem("noahorizontal");
        localStorage.removeItem("noahorizontalHover");
        // menuClick();
        responsive();
    }
});

$('#myonoffswitch35').on('click', function () {
    if (this.checked) {
        sidemenudropdown();
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
        $('#slide-left').removeClass('d-none');
        $('#slide-right').removeClass('d-none');
        document.querySelector('.horizontal .side-menu').style.flexWrap = 'nowrap'
        // $('#slide-left').addClass('d-none');
        // $('#slide-right').addClass('d-none');
        // document.querySelector('.horizontal .side-menu').style.flexWrap = 'wrap'
        // menuClick();
        localStorage.setItem("noahorizontal", "true");
        localStorage.removeItem("noasidebarMini");
        localStorage.removeItem("noahorizontalHover");
        checkHoriMenu();
        responsive();
    }
});

$('#myonoffswitch111').on('click', function () {
    if (this.checked) {
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
        $('body').addClass('horizontal-hover');
        $('body').addClass('horizontal');
        // $('#slide-left').addClass('d-none');
        // $('#slide-right').addClass('d-none');
        // document.querySelector('.horizontal .side-menu').style.flexWrap = 'wrap'
        document.querySelector('.horizontal .side-menu').style.flexWrap = 'nowrap';
        $('#slide-left').removeClass('d-none');
        $('#slide-right').removeClass('d-none');
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
        checkHoriMenu();
        responsive();
        localStorage.setItem("noahorizontalHover", "true");
        localStorage.removeItem("noasidebarMini");
        localStorage.removeItem("noahorizontal");

    }

});

function checkOptions() {

    // rtl
    if (document.querySelector('body').classList.contains('rtl')) {
        $('#myonoffswitch24').prop('checked', true);
    }
    // horizontal
    if (document.querySelector('body').classList.contains('horizontal')) {
        $('#myonoffswitch35').prop('checked', true);
    }
    // horizontal-hover
    if (document.querySelector('body').classList.contains('horizontal-hover')) {
        $('#myonoffswitch111').prop('checked', true);
    }
    // light header 
    if (document.querySelector('body').classList.contains('header-light')) {
        $('#myonoffswitch6').prop('checked', true);
    }
    // color header 
    if (document.querySelector('body').classList.contains('color-header')) {
        $('#myonoffswitch7').prop('checked', true);
    }
    // gradient header 
    if (document.querySelector('body').classList.contains('gradient-header')) {
        $('#myonoffswitch20').prop('checked', true);
    }
    // dark header 
    if (document.querySelector('body').classList.contains('dark-header')) {
        $('#myonoffswitch8').prop('checked', true);
    }

    // light menu
    if (document.querySelector('body').classList.contains('light-menu')) {
        $('#myonoffswitch3').prop('checked', true);
    }
    // color menu
    if (document.querySelector('body').classList.contains('color-menu')) {
        $('#myonoffswitch4').prop('checked', true);
    }
    // gradient menu
    if (document.querySelector('body').classList.contains('gradient-menu')) {
        $('#myonoffswitch19').prop('checked', true);
    }
    // dark menu
    if (document.querySelector('body').classList.contains('dark-menu')) {
        $('#myonoffswitch5').prop('checked', true);
    }
}
checkOptions()

// RESET SWITCHER TO DEFAULT
function resetData() {
    
    $('#myonoffswitch3').prop('checked', true);
    $('#myonoffswitch6').prop('checked', true);
    $('#myonoffswitch1').prop('checked', true);
    $('#myonoffswitch9').prop('checked', true);
    $('#myonoffswitch10').prop('checked', false);
    $('#myonoffswitch11').prop('checked', true);
    $('#myonoffswitch12').prop('checked', false);
    $('#myonoffswitch13').prop('checked', true);
    $('#myonoffswitch14').prop('checked', false);
    $('#myonoffswitch15').prop('checked', false);
    $('#myonoffswitch16').prop('checked', false);
    $('#myonoffswitch17').prop('checked', false);
    $('#myonoffswitch18').prop('checked', false);
    $('#myonoffswitch24').prop('checked', false);
    $('#myonoffswitch23').prop('checked', true);
    $('#myonoffswitch35').prop('checked', false);
    $('#myonoffswitch111').prop('checked', false);
    $('#myonoffswitch34').prop('checked', true);
    $('body')?.removeClass('bg-img4');
    $('body')?.removeClass('bg-img1');
    $('body')?.removeClass('bg-img2');
    $('body')?.removeClass('bg-img3');
    $('body')?.removeClass('dark-mode');
    $('body')?.removeClass('dark-menu');
    $('body')?.removeClass('color-menu');
    $('body')?.removeClass('gradient-menu');
    $('body')?.removeClass('dark-header');
    $('body')?.removeClass('color-header');
    $('body')?.removeClass('gradient-header');
    $('body')?.removeClass('layout-boxed');
    $('body')?.removeClass('icontext-menu');
    $('body')?.removeClass('icon-overlay');
    $('body')?.removeClass('closed-leftmenu');
    $('body')?.removeClass('hover-submenu');
    $('body')?.removeClass('hover-submenu1');
    $('body')?.removeClass('sidenav-toggled');
    $('body')?.removeClass('scrollable-layout');
    $('body')?.removeClass('rtl');
    $('body')?.addClass('ltr');
    //Vertical

    $('body').removeClass('horizontal');
    $('body').removeClass('horizontal-hover');
    $(".main-content").removeClass("hor-content");
    $(".main-content").addClass("app-content");
    $(".main-container").removeClass("container");
    $(".main-container").addClass("container-fluid");
    $(".app-header").removeClass("hor-header");
    $(".hor-header").addClass("app-header");
    $(".app-sidebar").removeClass("horizontal-main")
    $(".main-sidemenu").removeClass("container")
    $('#slide-left').removeClass('d-none');
    $('#slide-right').removeClass('d-none');
    $('body').addClass('sidebar-mini');


    //ltr
    $('#slide-left').removeClass('d-none');
    $('#slide-right').removeClass('d-none');
    $("html[lang=en]").attr("dir", "ltr");
    $('body').removeClass('rtl');
    $("head link#style").attr("href", $(this));
    (document.getElementById("style").setAttribute("href", "../assets/plugins/bootstrap/css/bootstrap.min.css"));
    var carousel = $('.owl-carousel');
    $.each(carousel, function (index, element) {
        // element == this
        var carouselData = $(element).data('owl.carousel');
        carouselData.settings.rtl = false; //don't know if both are necessary
        carouselData.options.rtl = false;
        $(element).trigger('refresh.owl.carousel');
    });
    localStorage.setItem('noaltr', true)
    localStorage.removeItem('noartl')
    if (!document.querySelector('body').classList.contains('login-img') && !document.querySelector('body').classList.contains('error-bg')) {
        checkHoriMenu();
        sidemenudropdown();
        responsive();
    }

}




