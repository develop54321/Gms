
'use strict';

$(function () {

    $("#ps-datepicker").datepicker({
        autoclose: true,
        format: 'dd-mm-yyyy',
        todayHighlight: true
    }).datepicker('update', new Date());

    $("#pe-datepicker").datepicker({
        autoclose: true,
        format: 'dd-mm-yyyy',
        todayHighlight: true
    }).datepicker('update', '');
});

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

function selectClient(client) {
    if (!client.id) { return client.text; }
    var $client = $(
        '<span><img src="../assets/images/users/' + client.element.value.toLowerCase() + '.jpg" class="rounded-circle avatar-sm" /> '
        + client.text + '</span>'
    );
    return $client;
};

$(".select2-client-search").select2({
    templateResult: selectClient,
    templateSelection: selectClient,
    escapeMarkup: function (m) { return m; }
});

// text editor
$(function (e) {
    $('#summernote').summernote();
});

$(function (e) {
    $('#summernote2').summernote();
});

//removing end date with checkbox
const endDateCheckboxContainer = document.querySelector('.end-date-checkbox-container');
const endDateCheckbox = document.querySelector('.end-date-checkbox');
const endDateContainer = document.querySelector('.end-date-container');
removeElementsOnCheck(endDateCheckboxContainer, endDateCheckbox, endDateContainer);

//display other files section
function showAndHideOtherDetails() {

    const otherDetails = document.querySelector('.other-details');
    const addFilesContainer = document.querySelector('.other-details-main');
    var upArrow = document.querySelector('.up-arrow');
    var downArrow = document.querySelector('.down-arrow');

    otherDetails.addEventListener('click', showAddFilesContainer);

    upArrow.classList.add('d-none');

    function showAddFilesContainer() {
        if (addFilesContainer.classList.contains('d-none')) {
            addFilesContainer.classList.remove('d-none');
            upArrow.classList.remove('d-none');
            downArrow.classList.add('d-none');

        }
        else {
            addFilesContainer.classList.add('d-none');
            upArrow.classList.add('d-none');
            downArrow.classList.remove('d-none');
        }
    }
}
showAndHideOtherDetails();

//display send notifications to client option
const clientCheckbox = document.querySelector('.client-checkbox');
const clientCheckboxContainer = document.querySelector('.client-checkbox-container');
const notificationsContainer = document.querySelector('.notifications-container');
addElementsOnCheck(clientCheckboxContainer, clientCheckbox, notificationsContainer);

//hide elements using checkbox
function removeElementsOnCheck(checkboxContainer, checkboxMain, elementToRemove) {

    checkboxContainer.addEventListener('click', mainFunction);

    function mainFunction() {
        if (checkboxMain.checked == true) {
            elementToRemove.classList.add('d-none');
        }
        else {
            elementToRemove.classList.remove('d-none');
        }
    }
}

//display elements using checkbox
function addElementsOnCheck(checkboxContainer, checkboxMain, elementToRemove) {

    checkboxContainer.addEventListener('click', mainFunction);

    function mainFunction() {
        if (checkboxMain.checked == true) {
            elementToRemove.classList.remove('d-none');
        }
        else {
            elementToRemove.classList.add('d-none');
        }
    }
}