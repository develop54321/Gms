const colBtn = document.querySelectorAll('#viewBtn');
const products = document.querySelectorAll('.product-each');

const itemContainer = document.querySelectorAll('.product-grid6');

const displayBtn = document.querySelectorAll('.layoutBtn');

const fourColBtn = document.querySelector('.four-col');
const threeColBtn = document.querySelector('.three-col')
const twoColBtn = document.querySelector('.two-col');

function fourCol($e) {
    'use strict'
    for (var i = 0; i < products.length; i++) {
        products[i].className = " ";
        products[i].className = "col-12 col-md-6 col-sm-6 col-lg-6 col-xl-3";
    }

    for (var i = 0; i < colBtn.length; i++) {
        colBtn[i].classList.remove('active');
    }

    var element = $e.target;
    element.classList.add('active');

}

function threeCol($e) {
    'use strict'
    for (var i = 0; i < products.length; i++) {
        products[i].className = " ";
        products[i].className = "col-12 col-md-6 col-sm-6 col-lg-6 col-xl-4";
    }

    for (var i = 0; i < colBtn.length; i++) {
        colBtn[i].classList.remove('active');
    }

    var element = $e.target;
    element.classList.add('active');
}

function twoCol($e) {
    'use strict'
    for (var i = 0; i < products.length; i++) {
        products[i].className = " ";
        products[i].className = "col-12 col-md-6 col-sm-6 col-lg-6 col-xl-6";
    }

    for (var i = 0; i < colBtn.length; i++) {
        colBtn[i].classList.remove('active');
    }

    var element = $e.target;
    element.classList.add('active');
}