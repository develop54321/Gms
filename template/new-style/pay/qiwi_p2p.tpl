<button type="button" onclick="submit();" class="btn btn-success btn-sm"/>Оплатить Qiwi</button>
<script>
    let url = '<?php echo $InfoPayment['qiwiLink'];?>';
    function submit(){
        window.open(url);
    }
</script>