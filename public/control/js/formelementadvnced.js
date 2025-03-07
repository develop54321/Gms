
'use strict';

$(function (e) {

	//select2 dropdown
	$('.select2').select2({
		minimumResultsForSearch: Infinity,
		width: '100%'
	});

	// Select2 by showing the search
	$('.select2-show-search').select2({
		minimumResultsForSearch: '',
		width: '100%'
	})

	//select2 style-01
	function select2Style1(data) {
		if (!data.id) { return data.text; }
		var $data = $(
			'<span><img src="../assets/images/users/' + data.element.value.toLowerCase() + '.jpg" class="rounded-circle avatar-sm" /> '
			+ data.text + '</span>'
		);
		return $data;
	};

	$(".select2-style1").select2({
		templateResult: select2Style1,
		templateSelection: select2Style1,
		escapeMarkup: function (m) { return m; }
	});//select2 style-01 ends

	/*---- date range picker ----*/
	//Date picker
	$('#datepicker-date').bootstrapdatepicker({
		format: "dd-mm-yyyy",
		viewMode: "date",
		multidate: true,
		multidateSeparator: "-",
	})

	//Month picker
	$('#datepicker-month').bootstrapdatepicker({
		format: "MM",
		viewMode: "months",
		minViewMode: "months",
		multidate: true,
		multidateSeparator: "-",
	})

	//Year picker
	$('#datepicker-year').bootstrapdatepicker({
		format: "yyyy",
		viewMode: "year",
		minViewMode: "years",
		multidate: true,
		multidateSeparator: "-",
	})
	/*---- date range picker ends ----*/


	/*---- jQuery UI Pickers ----*/
	// Datepicker
	$('.fc-datepicker').datepicker({
		showOtherMonths: true,
		selectOtherMonths: true,
		format: 'yyyy-mm-dd',
	});
	//Multiple Months Date Picker
	$('#datepickerNoOfMonths').datepicker({
		showOtherMonths: true,
		selectOtherMonths: true,
		format: 'yyyy-mm-dd',
		numberOfMonths: 2,
	});
	//Date picker style-01 (Bootstrap Date Picker)
	$("#bootstrapDatePicker1").datepicker({
		autoclose: true,
		format: 'yyyy-mm-dd',
		todayHighlight: true
	}).datepicker('update', new Date());

	/*---- jQuery UI Pickers ends ----*/


	// Simple Date Time Picker
	$('#datetimepicker1').appendDtpicker({
		closeOnSelected: true,
		onInit: function (handler) {
			var picker = handler.getPicker();
			$(picker).addClass('main-datetimepicker');
		}
	});
	// AmazeUI Date time picker
	$('#datetimepicker2').datetimepicker({
		format: 'yyyy-mm-dd hh:ii',
		autoclose: true
	});

	//bootstrap maxlength
	$('input#defaultconfig').maxlength({
		alwaysShow: true,
		warningClass: "badge badge-xs bg-warning",
		limitReachedClass: "badge badge-xs bg-primary"
	});
	$('input#thresholdConfig').maxlength({
		threshold: 20,
		warningClass: "badge badge-xs bg-warning",
		limitReachedClass: "badge badge-xs bg-primary"
	});
	$('input#alloptions').maxlength({
		alwaysShow: true,
		threshold: 10,
		separator: ' of ',
		preText: 'You have ',
		postText: ' chars remaining.',
		validate: true,
		warningClass: "badge badge-xs bg-warning",
		limitReachedClass: "badge badge-xs bg-primary"
	});
	$('textarea#textarea').maxlength({
		alwaysShow: true,
		warningClass: "badge badge-xs bg-warning",
		limitReachedClass: "badge badge-xs bg-primary"
	});
	$('input#place-top-left').maxlength({
		alwaysShow: true,
		placement: 'top-left',
		warningClass: "badge badge-xs bg-warning",
		limitReachedClass: "badge badge-xs bg-primary"
	});
	$('input#place-top-right').maxlength({
		alwaysShow: true,
		placement: 'top-right',
		warningClass: "badge badge-xs bg-warning",
		limitReachedClass: "badge badge-xs bg-primary"
	});
	$('input#place-bottom-left').maxlength({
		alwaysShow: true,
		placement: 'bottom-left',
		warningClass: "badge badge-xs bg-warning",
		limitReachedClass: "badge badge-xs bg-primary"
	});
	$('input#place-bottom-right').maxlength({
		alwaysShow: true,
		placement: 'bottom-right',
		warningClass: "badge badge-xs bg-warning",
		limitReachedClass: "badge badge-xs bg-primary"
	});
});
