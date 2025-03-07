(function ($) {
	"use strict";

	$('#wizard1').steps({
		headerTag: 'h4',
		bodyTag: 'div',
		autoFocus: true,
		titleTemplate: '<span class="number">#index#<\/span> <span class="title">#title#<\/span>'
	});
	$('#wizard2').steps({
		headerTag: 'h4',
		bodyTag: 'div',
		autoFocus: true,
		titleTemplate: '<span class="number">#index#<\/span> <span class="title">#title#<\/span>',
		onStepChanging: function (event, currentIndex, newIndex) {
			if (currentIndex < newIndex) {
				// Step 1 form validation
				if (currentIndex === 0) {
					var fname = $('#firstname').parsley();
					var lname = $('#lastname').parsley();
					if (fname.isValid() && lname.isValid()) {
						return true;
					} else {
						fname.validate();
						lname.validate();
					}
				}
				// Step 2 form validation
				if (currentIndex === 1) {
					var email = $('#email').parsley();
					if (email.isValid()) {
						return true;
					} else {
						email.validate();
					}
				}
				// Always allow step back to the previous step even if the current step is not valid.
			} else {
				return true;
			}
		}
	});
	$('#wizard3').steps({
		headerTag: 'h4',
		bodyTag: 'div',
		autoFocus: true,
		titleTemplate: '<span class="number">#index#<\/span> <span class="title">#title#<\/span>',
		stepsOrientation: 1
	});

	//_________accordion-wizard
	var options = {
		mode: 'wizard',
		autoButtonsNextClass: 'btn btn-primary float-end',
		autoButtonsPrevClass: 'btn btn-secondary',
		stepNumberClass: 'badge rounded-pill bg-primary me-1',
		onSubmit: function () {
			alert('Form submitted!');
			return true;
		}
	}
	$("#form").accWizard(options);

})(jQuery); 