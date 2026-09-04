<section class="page">
    <div class="container">
        <h1 class="content-title">
            Статистика Мастер сервера
        </h1>
        <hr/>

        <div class="stats-card">
            <div id="container"></div>
        </div>
    </div>
</section>
<style>
    .stats-card{
        background:var(--surface); border:1px solid var(--border); border-radius:var(--radius);
        padding:16px; box-shadow:var(--shadow-sm);
    }
</style>
<script type="text/javascript">
    $(function () {
        var chart;
        $(document).ready(function () {
            Highcharts.setOptions({
                chart: {
                    backgroundColor: 'transparent',
                    style: { fontFamily: "'Manrope', system-ui, sans-serif" }
                },
                title: { style: { color: '#ffffff' } },
                subtitle: { style: { color: '#9aa1b5' } },
                xAxis: {
                    labels: { style: { color: '#9aa1b5' } },
                    lineColor: '#242b3d',
                    tickColor: '#242b3d'
                },
                yAxis: {
                    labels: { style: { color: '#9aa1b5' } },
                    gridLineColor: '#1b2233',
                    title: { style: { color: '#9aa1b5' } }
                },
                legend: { itemStyle: { color: '#e8eaf0' }, itemHoverStyle: { color: '#ffffff' } },
                colors: ['#5b7fff', '#2ed8a7', '#f5c451', '#ff5a5f'],
                credits: { style: { color: '#6b7186' } }
            });

            chart = new Highcharts.Chart({
                chart: {
                    renderTo: 'container', type: 'line'
                },
                title: {
                    text: 'Запросы к мастерсерверу'
                },
                subtitle: {
                    text: 'за последние 7 дней'
                },
                xAxis: {
                    categories: ['6 дней назад', '5 дней назад', '4 дня назад', '3 дня назад', '2 дня назад', 'Вчера', 'Сегодня']
                },
                yAxis: {
                    min: 0,
                    title: {
                        text: 'Количество IP адресов'
                    }
                },
                legend: {
                    layout: 'vertical',
                    backgroundColor: '#1b2030',
                    borderColor: '#242b3d',
                    borderWidth: 1,
                    borderRadius: 8,
                    align: 'left',
                    verticalAlign: 'top',
                    x: 100,
                    y: 70,
                    floating: true,
                    shadow: false
                },
                tooltip: {
                    formatter: function () {
                        return this.y + ' игрока(ов)';
                    }
                },
                plotOptions: {
                    column: {
                        pointPadding: 0.2, borderWidth: 0
                    }
                },
                series: [{
                    name: 'Уникальные запросы CS 1.6',
                    <?php echo $str;?>
                }]
            });
        });

    });
</script>

<script src="/public/js/highcharts/highcharts.js"></script>
<script src="/public/js/highcharts/exporting.js"></script>

