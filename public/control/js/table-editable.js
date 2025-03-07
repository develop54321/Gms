
"use strict";

$(function (e) {

	var data = {};
	$(".table-edit tr").editable({
		keyboard: true,
		button: true,
		buttonSelector: ".edit-icn",
		dropdowns: {
			gender: ["Male", "Female"]
		},
		maintainWidth: true,
		edit: function (values) {
			$(".edit-icn i", this).removeClass("fe-pen").addClass("fe-save").attr("title", "Save");
		},
		save: function (values) {
			$(".edit-icn i", this).removeClass("fe-save").addClass("fe-pen").attr("title", "Edit"), this in data && (data[this].destroy(), delete data[this])
		},
		cancel: function (values) {
			$(".edit-icn i", this).removeClass("fe-save").addClass("fe-pen").attr("title", "Edit"), this in data && (data[this].destroy(), delete data[this])
		}
	})

	// Editable Responsive Table
	$('#editable-responsive-table').DataTable({
		responsive: true,
		language: {
			searchPlaceholder: 'Search...',
			sSearch: '',
		}
	});

	// Editable File-Export Data Table
	var table = $('#editable-file-datatable').DataTable({
		buttons: ['copy', 'excel', 'pdf', 'colvis'],
		responsive: true,
		language: {
			searchPlaceholder: 'Search...',
			sSearch: '',
		}
	});
	table.buttons().container()
		.appendTo('#editable-file-datatable_wrapper .col-md-6:eq(0)');

	// Delete Data Table
	var table = $('#delete-datatable').DataTable({
		language: {
			searchPlaceholder: 'Search...',
			sSearch: '',
		}
	});
	$('#delete-datatable tbody').on('click', 'tr', function () {
		if ($(this).hasClass('selected')) {
			$(this).removeClass('selected');
		}
		else {
			table.$('tr.selected').removeClass('selected');
			$(this).addClass('selected');
		}
	});
	$('#button').on("click", function () {
		table.row('.selected').remove().draw(false);
	});

	// Select2 
	$('.select2').select2({
		minimumResultsForSearch: Infinity
	});


});