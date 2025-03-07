
$(function (e) {
	'use strict'

    //select2 dropdown
    $('.select2-show-search').select2({
        minimumResultsForSearch: Infinity,
        width: '100%'
    });

    //Date Picker
    $("#bootstrapDatePicker").datepicker({
        autoclose: true,
        format: 'dd-mm-yyyy',
    }).datepicker('update', new Date());

    //Time Picker
    $('#tp3').timepicker();

    $(document).on('click', '#setTimeButton', function () {
        $('#tp3').timepicker('setTime', new Date());
    });
})
