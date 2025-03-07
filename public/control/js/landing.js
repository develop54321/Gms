(function ($) {
	"use strict";

window.addEventListener("load", function (e) {
    $("#global-loader").fadeOut("slow");
})

// ______________ Back to Top
$(window).on("scroll", function (e) {
    if ($(this).scrollTop() > 0) {
        $('#back-to-top').fadeIn('slow');
    } else {
        $('#back-to-top').fadeOut('slow');
    }


    if ($(window).scrollTop() >= 10) {
        $('.horizontal-main').addClass('fixed-header');
        $('.horizontal-main').addClass('visible-title');
        document.querySelector('.demo-screen-headline').style.paddingTop='70px'
    } else {
        $('.horizontal-main').removeClass('fixed-header');
        $('.horizontal-main').removeClass('visible-title');
        document.querySelector('.demo-screen-headline').style.paddingTop='0px'
    }

});
$("#back-to-top").on("click", function (e) {
    $("html, body").animate({
        scrollTop: 0
    }, 0);
    return false;
});// ______________Testimonial-owl-carousel2

$(document).on("ready",function(){
    $('#myCarousel').carousel({
        interval: 3000,
    })
});
    
    var owl = $('.testimonial-owl-carousel2');
    owl.owlCarousel({
        margin: 25,
        loop: true,
        nav: false,
        autoplay: true,
        dots: false,
        animateOut: 'fadeOut',
        smartSpeed: 150,
        responsive: {
            0: {
                items: 1
            },
            600: {
                items: 2,
            },
            1300: {
                items: 3,
            }
        }
    })


    // ______________Owl-carousel-icons2
    var owl = $('.owl-carousel-icons2');
    owl.owlCarousel({
        loop: true,
        rewind: false,
        margin: 25,
        animateIn: 'fadeInDowm',
        animateOut: 'fadeOutDown',
        autoplay: false,
        autoplayTimeout: 5000, // set value to change speed
        autoplayHoverPause: true,
        dots: false,
        nav: true,
        autoplay: true,
        responsiveClass: true,
        responsive: {
            0: {
                items: 1,
                nav: true
            },
            600: {
                items: 2,
                nav: true
            },
            1300: {
                items: 4,
                nav: true
            }
        }
    })


    try {
        const tobii = new Tobii()
    } catch (err) { }

    // ______________Testimonial-owl-carousel3
    var owl = $('.testimonial-owl-carousel3');
    owl.owlCarousel({
        margin: 25,
        loop: true,
        nav: false,
        autoplay: true,
        dots: true,
        responsive: {
            0: {
                items: 1
            }
        }
    })
    $('.customer-logos').slick({
        slidesToShow: 6,
        slidesToScroll: 1,
        autoplay: true,
        autoplaySpeed: 1000,
        arrows: false,
        dots: false,
        pauseOnHover: false,
        responsive: [{
            breakpoint: 768,
            settings: {
                slidesToShow: 3
            }
        }, {
            breakpoint: 520,
            settings: {
                slidesToShow: 2
            }
        }]
    });

    $('.responsive-screens').slick({
        slidesToShow: 1,
        slidesToScroll: 1,
        autoplay: true,
        autoplaySpeed: 5000,
        arrows: false,
        dots: false,
        pauseOnHover: false,
        responsive: [{
            breakpoint: 768,
            settings: {
                slidesToShow: 1
            }
        }, {
            breakpoint: 520,
            settings: {
                slidesToShow: 1
            }
        }]
    });


$('.testi1').owlCarousel({
    loop: true,
    margin: 30,
    nav: false,
    dots: true,
    autoplay: true,
    responsiveClass: true,
    responsive: {
        0: {
            items: 1,
            nav: false
        },
        1024: {
            items: 2
        }
    }
});

$('.banner-carousel').owlCarousel({
    loop: true,
    margin: 30,
    nav: false,
    dots: true,
    autoplay: true,
    responsiveClass: true,
    responsive: {
        0: {
            items: 1,
        },
        600: {
            items: 1,
        },
        1300: {
            items: 1,
        }
    }
});
// ______________ CARD
const DIV_CARD = 'div.card';
// ______________ FUNCTIONS FOR COLLAPSED CARD
$(document).on('click', '[data-bs-toggle="card-collapse"]', function (e) {
    let $card = $(this).closest(DIV_CARD);
    $card.toggleClass('card-collapsed');
    e.preventDefault();
    return false;
});


// ==== for menu scroll
const pageLink = document.querySelectorAll(".nav-scroll");

pageLink.forEach((elem) => {
    elem.addEventListener("click", (e) => {
        e.preventDefault();
        document.querySelector(elem.getAttribute("href")).scrollIntoView({
            behavior: "smooth",
            offsetTop: 1 - 60,
        });
    });
});
// section menu active
function onScroll(event) {
    const sections = document.querySelectorAll(".nav-scroll");
    const scrollPos =
        window.pageYOffset ||
        document.documentElement.scrollTop ||
        document.body.scrollTop;

    for (let i = 0; i < sections.length; i++) {
        const currLink = sections[i];
        const val = currLink.getAttribute("href");
        const refElement = document.querySelector(val);
        const scrollTopMinus = scrollPos + 73;
        if (
            refElement.offsetTop <= scrollTopMinus &&
            refElement.offsetTop + refElement.offsetHeight > scrollTopMinus) {
            document
                .querySelector(".nav-scroll")
                .classList.remove("active");
            currLink.classList.add("active");
        } else {
            currLink.classList.remove("active");
        }
    }
}

window.document.addEventListener("scroll", onScroll);
// ___________TOOLTIP
var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
    return new bootstrap.Tooltip(tooltipTriggerEl)
})

//animation
window.addEventListener('scroll', reveal);

function reveal(){
    var reveals = document.querySelectorAll('.reveal');
  
    for(var i = 0; i < reveals.length; i++){
  
      var windowHeight = window.innerHeight;
      var cardTop = reveals[i].getBoundingClientRect().top;
      var cardRevealPoint = 150;
  
    //   console.log('condition', windowHeight - cardRevealPoint)
  
      if(cardTop < windowHeight - cardRevealPoint){
        reveals[i].classList.add('active');
      }
      else{
        reveals[i].classList.remove('active');
      }
    }
  }
  
reveal();


// section menu active
function onScroll(event) {
    const sections = document.querySelectorAll(".side-menu__item");
    const scrollPos =
        window.pageYOffset ||
        document.documentElement.scrollTop ||
        document.body.scrollTop;

    sections.forEach((elem) => {
        const val = elem.getAttribute("href");
        const refElement = document.querySelector(val);
        const scrollTopMinus = scrollPos + 73;
        if (
            refElement.offsetTop <= scrollTopMinus &&
            refElement.offsetTop + refElement.offsetHeight > scrollTopMinus
        ) {
            elem.classList.add("active");
        } else {
            elem.classList.remove("active");
        }
    })
}
window.document.addEventListener("scroll", onScroll);


// DEMO Swticher Base
jQuery('.demo-icon').click(function() {
    if ($('.demo_changer').hasClass("active")) {
        $('.demo_changer').animate({ "right": "-280px" }, function() {
            $('.demo_changer').removeClass("active");
        });
    } else {
        $('.demo_changer').animate({ "right": "0px" }, function() {
            $('.demo_changer').addClass("active");
        });
    }
});

// Switcher Close //
$(document).on("click", ".page", function() {
    if ($('.demo_changer').hasClass("active")) {
        $('.demo_changer').animate({ "right": "-280px" }, function() {
            $('.demo_changer').removeClass("active");
        });
    }
});


// RTL STYLE START
$('#myonoffswitch24').on('click', function () {
    if (this.checked) {
        $('body').addClass('rtl');
        $('.slick-slider').slick('slickSetOption', 'rtl', true);
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
        localStorage.setItem('noartl', true)
        localStorage.removeItem('noaltr')
    }
});

// RTL STYLE END

// LTR STYLE START
$('#myonoffswitch23').on('click', function () {
    if (this.checked) {
        $('body').addClass('ltr');
        $('.slick-slider').slick('slickSetOption', 'rtl', false);
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
    }
});
// LTR STYLE END

    // LIGHT THEME START
    $(document).on("click", '#myonoffswitch1', function () {
        if (this.checked) {
            $('body').removeClass('dark-mode');
            $('body').addClass('light-mode');
            $('#myonoffswitch3').prop('checked', true);
            $('#myonoffswitch6').prop('checked', true);
            localStorage.removeItem("noadarkMode")
        }
    });
    // LIGHT THEME END

    // DARK THEME START
    $(document).on("click", '#myonoffswitch2', function () {
        if (this.checked) {
            $('body').addClass('dark-mode');
            $('body').removeClass('light-mode');

            $('#myonoffswitch5').prop('checked', true);
            $('#myonoffswitch8').prop('checked', true);
            localStorage.setItem("noadarkMode", true)
        }
    });
    // DARK THEME END
    
    $(document).on('click', '[data-bs-toggle="sidebar"]', function (event) {
        event.preventDefault();
        $('.app').toggleClass('sidenav-toggled');
    });

    if (window.innerWidth <= 992) {
        $('body').removeClass('sidenav-toggled');
    }
    
    function landingPageLocalstorage(){
        if(localStorage.getItem("noartl")){
            $('body').addClass('rtl')
        }
        if(localStorage.getItem("noadarkMode")){
            $('body').addClass('dark-mode')
        }
    }
    landingPageLocalstorage()
    
if ($("body").hasClass("rtl")) {
    $('.slick-slider').slick('slickSetOption', 'rtl', true);
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

    $('#myonoffswitch24').prop('checked', true);
}
if ($("body").hasClass("dark-mode")) {
    $('body').removeClass('light-mode');

    $('#myonoffswitch2').prop('checked', true);
}
})(jQuery); 

// RESET SWITCHER TO DEFAULT
function resetData() {
    $('#myonoffswitch23').prop('checked', true);
    $('#myonoffswitch1').prop('checked', true);
    $('body').addClass('ltr');
    $('.slick-slider').slick('slickSetOption', 'rtl', false);
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
    $('body').removeClass('dark-mode');
    $('body').addClass('light-mode');
    $('#myonoffswitch3').prop('checked', true);
    $('#myonoffswitch6').prop('checked', true);
    localStorage.clear()
}




// Dark Theme
// $('body').addClass('dark-mode');

// RTL
// $('body').addClass('rtl');
    