$(function () {
	'use strict'

	const ps5 = new PerfectScrollbar('#ChatBody', {
		useBothWheelAxes: true,
		suppressScrollX: true,
	});
	const ps6 = new PerfectScrollbar('.profile-details-main', {
		useBothWheelAxes: true,
		suppressScrollX: true,
	});
});