
'use strict'

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
    }).datepicker('update', '11-11-2021');

});

// text editor
$(function (e) {
    $('#summernote3').summernote();
});

$(function (e) {
    $('#summernote4').summernote();
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


function selectStatus(status) {

    if (!status.id) { return status.text; }
    var $status = $(
        '<span class="status-indicator projects">' + status.text + '</span>',
    );
    var $statusText = $status.text().split(" ").join("").toLowerCase();
    if ($statusText === "inprogress") {
        $status.addClass("in-progress");
    }
    else if ($statusText === "onhold") {
        $status.addClass("on-hold");
    }
    else if ($statusText === "completed") {
        $status.addClass("completed");
    }
    else {
        $status.addClass("empty");
    }
    return $status;
};


$(".select2-status-search").select2({
    templateResult: selectStatus,
    templateSelection: selectStatus,
    escapeMarkup: function (s) { return s; }
});


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
    escapeMarkup: function (c) { return c; }
});

function select2AssignTo() {

    $(".select2-assignTo-search").select2({
        templateResult: selectClient,
        templateSelection: selectClient,
        escapeMarkup: function (a) { return a; }
    });
}

//show and hide end date element
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
            select2AssignTo();
        }
        else {
            addFilesContainer.classList.add('d-none');
            upArrow.classList.add('d-none');
            downArrow.classList.remove('d-none');
        }
    }
}
showAndHideOtherDetails();

//input value max value to 100
function handleInput(inpt) {
    if (inpt.value > 100) {
        inpt.value = 100;
    }
}

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