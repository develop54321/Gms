$(function (e) {
	'use strict'

	// Input Masks
	$('#ssnMask-card').mask('9999-9999-9999-9999');
	$('#ssnMask-cvv').mask('999');

	//select2 dropdown
	$('.select2').select2({
		minimumResultsForSearch: Infinity,
		width: '100%'
	});
});



//show password
function showPassword(inputElement, showBtn, eyeOpen, eyeClose) {
	'use strict'
	showBtn.addEventListener('click', () => {
		if (inputElement.type == 'password') {
			inputElement.type = 'text'
			eyeOpen.classList.add('d-none');
			eyeClose.classList.remove('d-none');
		}
		else {
			inputElement.type = 'password';
			eyeOpen.classList.remove('d-none');
			eyeClose.classList.add('d-none');
		}
	})
}

showPassword(passwordElement, showBtn, eyeOpen, eyeClose);