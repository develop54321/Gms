
'use strict';

// Select2
$('.select2').select2({
    minimumResultsForSearch: Infinity,
    width: '100%'
})

// Select2 by showing the search
$('.select2-show-search').select2({
    minimumResultsForSearch: '',
    width: '100%'
})

// USER IMAGES IN SELECT2 SEARCH
function selectClient (client) {
    if (!client.id) { return client.text; }
    var $client = $(
      '<span><img src="../assets/images/users/' +  client.element.value.toLowerCase() + '.jpg" class="rounded-circle avatar-sm" /> '
       + client.text +  '</span>'
   );
   return $client;
};
// USER IMAGES IN SELECT2 SEARCH

// FLAG IMAGES IN SELECT2 SEARCH
function selectCountry (country) {
    if (!country.id) { return country.text; }
    if(country.element.value.toLowerCase() !== 'def'){
        var $country = $(
            '<span><img src="../assets/images/flags/' +  country.element.value.toLowerCase() + '.svg" class="br-5 avatar-sm" /> '
            + country.text +  '</span>'
       );
       return $country;
    }
};

$(".select2-country-search").select2({
    minimumResultsForSearch: '',
    width: '100%'
});

// FLAG IMAGES IN SELECT2 SEARCH

// show password
function showPassword(){
    const showPasswordBtn = document.querySelector('.show-password');
    const inputMain = document.querySelector('.input-password');
    const eyeOpenIcon = document.querySelector('.eye-open');
    const eyeCloseIcon = document.querySelector('.eye-close');

    showPasswordBtn.addEventListener('click', changeInputType);

    function changeInputType(){

        if(inputMain.type === "password"){
            inputMain.type = "text";
            eyeCloseIcon.classList.remove('d-none');
            eyeOpenIcon.classList.add('d-none');
        }
        else{
            inputMain.type = "password";
            eyeCloseIcon.classList.add('d-none');
            eyeOpenIcon.classList.remove('d-none');
        }
    }
}
showPassword();