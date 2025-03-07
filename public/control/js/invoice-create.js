
'use strict'

//disply textarea on click
function displayTextArea() {

    var textAreaElement = document.querySelector('#shipping-address'),
        addAddressBtn = document.querySelector('#addShippingAddress');

    addAddressBtn.addEventListener('click', () => {
        if (textAreaElement.classList.contains('d-none')) {
            textAreaElement.classList.remove('d-none');
        }
        else {
            textAreaElement.classList.add('d-none');
        }
        addAddressBtn.classList.add('d-none')
    })

}
displayTextArea();


//adding and removing invoice
function addRemoveInvoiceItem() {
    var invoiceContainer = document.querySelector('.product-description-list');
    var invoiceEach = document.querySelector('.product-description-each')

    //remove product invoice
    function removeProductInvoice() {
        setInterval(() => {
            setTimeout(() => {
                var removeBtn = document.querySelectorAll('.delete-row-btn');
                for (let i = 0; i < removeBtn.length; i++) {
                    removeBtn[i].addEventListener('click', removeInvoice);
                }
            }, 1);
        }, 1);

        function removeInvoice($e) {
            invoiceContainer.removeChild($e.target.parentElement)
        }
    }
    removeProductInvoice();

    //add product invoice
    function addProductInvoice() {
        var invoiceEachCopy = invoiceEach.cloneNode(true);

        var addBtn = document.querySelector('.add-invoice-item-btn');

        addBtn.addEventListener('click', addInvoice);

        function addInvoice() {
            var newInvoice = invoiceEachCopy.cloneNode(true);
            invoiceContainer.appendChild(newInvoice);
            select2Search(); //to render select2 options in invoice
        }
    }
    addProductInvoice();
}
addRemoveInvoiceItem();

//date pickers
$(function () {
    $("#inv-datepicker").datepicker({
        autoclose: true,
        format: 'dd-mm-yyyy',
        todayHighlight: true
    }).datepicker('update', new Date());

    $("#due-datepicker").datepicker({
        autoclose: true,
        format: 'dd-mm-yyyy',
        todayHighlight: true
    }).datepicker('update',);
});

// Select2
$('.select2').select2({
    minimumResultsForSearch: Infinity,
    width: '100%'
})

// Select2 by showing the search
function select2Search() {

    $('.select2-show-search').select2({
        minimumResultsForSearch: '',
        width: '100%'
    })
}
select2Search();

//select2 client dropdown with search
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