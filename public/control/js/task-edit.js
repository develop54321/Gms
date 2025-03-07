
"use strict";

$(function () {

    $("#date1-datepicker").datepicker({
        autoclose: true,
        format: 'dd-mm-yyyy',
        todayHighlight: true
    }).datepicker('update', '30-10-2021');
    
    $("#date2-datepicker").datepicker({
        autoclose: true,
        format: 'dd-mm-yyyy',
        todayHighlight: true
    }).datepicker('update', '');

    
    $("#date3-datepicker").datepicker({
        autoclose: true,
        format: 'dd-mm-yyyy',
        todayHighlight: true
    }).datepicker('update', new Date());
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

function select2StatusSearch() {
    $(".select2-status-search").select2({
        templateResult: selectStatus,
        templateSelection: selectStatus,
        escapeMarkup: function (s) { return s; }
    });
}
select2StatusSearch();

function selectClient(client) {
    if (!client.id) { return client.text; }
    var $client = $(
        '<span><img src="../assets/images/users/' + client.element.value.toLowerCase() + '.jpg" class="rounded-circle avatar-sm ms-1" /> '
        + client.text + '</span>'
    );
    return $client;
};


$(".select2-client-search").select2({
    templateResult: selectClient,
    templateSelection: selectClient,
    escapeMarkup: function (m) { return m; }
});


//removing end date with checkbox
const noTaskEndDateCheckboxContainer = document.querySelector('.no-taskEnd-checkbox-container');
const noTaskEndDateCheckbox = document.querySelector('.no-taskEnd-date-checkbox');
const taskEndDateContainer = document.querySelector('.task-endDate-container');

checkingCheckBox(noTaskEndDateCheckbox, taskEndDateContainer); //checking whether checked or not.
removeElementsOnCheck(noTaskEndDateCheckboxContainer, noTaskEndDateCheckbox, taskEndDateContainer);	//main task

//removing subtask end date with checkbox
const noSubtaskEndDateCheckboxContainer = document.querySelector('.no-subtaskEnd-checkbox-container');
const noSubtaskEndDateCheckbox = document.querySelector('.no-subtaskEnd-date-checkbox');
const subtaskEndDateContainer = document.querySelector('.subtask-endDate-container');

checkingCheckBox(noSubtaskEndDateCheckbox, subtaskEndDateContainer); //checking whether checked or not
removeElementsOnCheck(noSubtaskEndDateCheckboxContainer, noSubtaskEndDateCheckbox, subtaskEndDateContainer);	//sub task

function checkingCheckBox(checkboxMain, elementToRemove) {

    if (checkboxMain.checked == true) {
        elementToRemove.classList.add('d-none');
    }
    else {
        elementToRemove.classList.remove('d-none');
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
            select2StatusSearch();

        }
        else {
            addFilesContainer.classList.add('d-none');
            upArrow.classList.add('d-none');
            downArrow.classList.remove('d-none');
        }
    }
}
showAndHideOtherDetails();


//display dependent task
function showAndHideDependentTask() {
    const taskDependedBtn = document.querySelector('.task-depended-container');
    const taskDependedCheckbox = document.querySelector('.task-depended-checkbox');
    const dependedTaskMain = document.querySelector('.depended-task-main');

    taskDependedBtn.addEventListener('click', displayDependedTask);

    function displayDependedTask() {
        if (taskDependedCheckbox.checked == true) {
            dependedTaskMain.classList.remove('d-none');
        }
        else {
            dependedTaskMain.classList.add('d-none');
        }
    }
}
showAndHideDependentTask();
