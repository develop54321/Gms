<div id="container"></div>
<script type="text/javascript">
        $(function () {
            var chart;
            $(document).ready(function() {
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
                        layout: 'vertical',	backgroundColor: '#FFFFFF', align: 'left', verticalAlign: 'top', x: 100, y: 70, floating: true, shadow: true
                    },
                    tooltip: {
                        formatter: function() {
                            return this.y +' игрока(ов)';
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

    <script src="http://code.highcharts.com/highcharts.js"></script>
    <script src="http://code.highcharts.com/modules/exporting.js"></script>
</head>
