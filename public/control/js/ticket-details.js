
$(function () {
    "use strict";

    // Select2 by showing the search
    $('.select2-show-search').select2({
        minimumResultsForSearch: '',
        width: '100%'
    })

    // Date picker style-01 (Bootstrap Date Picker)
    $("#bootstrapDatePicker3").datepicker({
        autoclose: true,
        format: 'dd-mm-yyyy',
        todayHighlight: true
    }).datepicker('update', '11-01-2021');

    // ticket status with indicator
    function ticketStatus(status) {
        if (!status.id) { return status.text; }
        var $status = $(
            '<span class="status-indicator tickets">' + status.text + '</span>',
        );
        var $statusText = $status.text().split(" ").join("").toLowerCase();
        if ($statusText === "open") {
            $status.addClass("open");
        }
        else if ($statusText === "closed") {
            $status.addClass("closed");
        }
        else if ($statusText === "pending") {
            $status.addClass("pending");
        }
        else if ($statusText === "resolved") {
            $status.addClass("resolved");
        }
        else {
            $status.addClass("empty");
        }
        return $status;
    };

    $(".ticket-status-search").select2({
        templateResult: ticketStatus,
        templateSelection: ticketStatus,
        escapeMarkup: function (s) { return s; }
    });

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

});