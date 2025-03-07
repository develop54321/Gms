
'use strict';

$(function(e) {

	/*----- Line Chart-01 ----*/
	var chart = document.getElementById('echart1');
	// var chart  = echarts.init(document.querySelector('#echart1'), null);

	var chartdata = [{
		name: 'sales',
		type: 'bar',
		data: [10, 15, 9, 18, 10, 15]
	}, {
		name: 'profit',
		type: 'line',
		smooth: true,
		data: [8, 5, 25, 10, 10]
	}, {
		name: 'growth',
		type: 'bar',
		data: [10, 14, 10, 15, 9, 25]
	}];

	var barChart = echarts.init(chart);
	var option = {
		grid: {
			top: '6',
			right: '0',
			bottom: '17',
			left: '25',
		},
		xAxis: {
			data: ['2014', '2015', '2016', '2017', '2018'],
			axisLine: {
				lineStyle: {
					color: 'rgba(119, 119, 142, 0.2)'
				}
			},
			axisLabel: {
				fontSize: 10,
				color: '#9ba6b5'
			}
		},
		tooltip: {
			show: true,
			showContent: true,
			alwaysShowContent: true,
			triggerOn: 'mousemove',
			trigger: 'axis',
			axisPointer: {
				label: {
					show: false,
				}
			}
		},
		yAxis: {
			splitLine: {
				lineStyle: {
					color: 'rgba(119, 119, 142, 0.2)'
				}
			},
			axisLine: {
				lineStyle: {
					color: 'rgba(119, 119, 142, 0.2)'
				}
			},
			axisLabel: {
				fontSize: 10,
				color: '#9ba6b5'
			}
		},
		series: chartdata,
		color: ['#b7dd88', '#9ad0f5', '#ffb0c1', ]
	};
	barChart.setOption(option);
	window.addEventListener('resize',function(){
        barChart.resize();
    })
	
	/*----- Line & Bar Chart -----*/
	var chartdata2 = [{
		name: 'sales',
		type: 'line',
		smooth: true,
		data: [12, 25, 12, 35, 12, 38],
		color: ['#9ad0f5']
	}, {
		name: 'Profit',
		type: 'line',
		smooth: true,
		size: 10,
		data: [8, 12, 28, 10, 10, 12],
		color: ['#ffe6aa']
	}];

	var chart2 = document.getElementById('echart2');
	var barChart2 = echarts.init(chart2);
	var option2 = {
		grid: {
			top: '6',
			right: '0',
			bottom: '17',
			left: '25',
		},
		xAxis: {
			data: ['2014', '2015', '2016', '2017', '2018'],
			axisLine: {
				lineStyle: {
					color: 'rgba(119, 119, 142, 0.2)'
				}
			},
			axisLabel: {
				fontSize: 10,
				color: '#9ba6b5'
			}
		},
		yAxis: {
			splitLine: {
				lineStyle: {
					color: 'rgba(119, 119, 142, 0.2)'
				}
			},
			axisLine: {
				lineStyle: {
					color: 'rgba(119, 119, 142, 0.2)'
				}
			},
			axisLabel: {
				fontSize: 10,
				color: '#9ba6b5'
			}
		},
		series: chartdata2
	};
	barChart2.setOption(option2);
	window.addEventListener('resize',function(){
        barChart2.resize();
    })

	/*----- Line Chart-02 -----*/
	var chart3 = document.getElementById('echart3');
	var option3 = {
		grid: {
			top: '6',
			right: '0',
			bottom: '17',
			left: '32',
		},
		xAxis: {
			type: 'value',
			axisLine: {
				lineStyle: {
					color: 'rgba(119, 119, 142, 0.2)'
				}
			},
			axisLabel: {
				fontSize: 10,
				color: '#9ba6b5'
			}
		},
		yAxis: {
			type: 'category',
			data: ['2014', '2015', '2016', '2017', '2018'],
			splitLine: {
				lineStyle: {
					color: 'rgba(119, 119, 142, 0.2)'
				}
			},
			axisLine: {
				lineStyle: {
					color: '#c0dfd8'
				}
			},
			axisLabel: {
				fontSize: 10,
				color: '#9ba6b5'
			}
		},
		series: chartdata,
		color: ['#a4dfdf', '#ffb0c1', '#ffcf9f',]
	};
	var barChart3 = echarts.init(chart3);
	barChart3.setOption(option3);
	window.addEventListener('resize',function(){
        barChart3.resize();
    })

	/*-----echart4-----*/
	var chart4 = document.getElementById('echart4');
	var option4 = {
		grid: {
			top: '6',
			right: '0',
			bottom: '17',
			left: '32',
		},
		xAxis: {
			type: 'value',
			axisLine: {
				lineStyle: {
					color: 'rgba(119, 119, 142, 0.2)'
				}
			},
			axisLabel: {
				fontSize: 10,
				color: '#9ba6b5'
			}
		},
		yAxis: {
			type: 'category',
			data: ['2014', '2015', '2016', '2017', '2018'],
			splitLine: {
				lineStyle: {
					color: 'rgba(119, 119, 142, 0.2)'
				}
			},
			axisLine: {
				lineStyle: {
					color: 'rgba(119, 119, 142, 0.2)'
				}
			},
			axisLabel: {
				fontSize: 10,
				color: '#9ba6b5'
			}
		},
		series: chartdata2,
		color: ['#0774f8', '#d43f8d', '#09ad95']
	};
	var barChart4 = echarts.init(chart4);
	barChart4.setOption(option4);
	window.addEventListener('resize',function(){
        barChart4.resize();
    })

	/*----- Bar Chart-01 -----*/
	var chart5 = document.getElementById('echart5');
	var chartdata3 = [{
		name: 'sales',
		type: 'bar',
		stack: 'Stack',
		data: [14, 18, 20, 14, 29, 21, 25, 14, 24]
	}, {
		name: 'Profit',
		type: 'bar',
		stack: 'Stack',
		data: [12, 14, 15, 50, 24, 24, 10, 20, 30]
	}];
	var option5 = {
		grid: {
			top: '6',
			right: '0',
			bottom: '17',
			left: '25',
		},
		xAxis: {
			data: ['2010', '2011', '2012', '2013', '2014', '2015', '2016', '2017', '2018'],
			axisLine: {
				lineStyle: {
					color: 'rgba(119, 119, 142, 0.2)'
				}
			},
			axisLabel: {
				fontSize: 10,
				color: '#9ba6b5'
			}
		},
		yAxis: {
			splitLine: {
				lineStyle: {
					color: 'rgba(119, 119, 142, 0.2)'
				}
			},
			axisLine: {
				lineStyle: {
					color: 'rgba(119, 119, 142, 0.2)'
				}
			},
			axisLabel: {
				fontSize: 10,
				color: '#9ba6b5'
			}
		},
		series: chartdata3,
		color: ['#ffcf9f', '#9ad0f5']
	};
	var barChart5 = echarts.init(chart5);
	barChart5.setOption(option5);
	window.addEventListener('resize',function(){
        barChart5.resize();
    })

	/*----- Bar Chart-02 -----*/
	var chart6 = document.getElementById('echart6');
	var option6 = {
		grid: {
			top: '6',
			right: '10',
			bottom: '17',
			left: '32',
		},
		xAxis: {
			type: 'value',
			axisLine: {
				lineStyle: {
					color: 'rgba(119, 119, 142, 0.2)'
				}
			},
			axisLabel: {
				fontSize: 10,
				color: '#9ba6b5'
			}
		},
		yAxis: {
			type: 'category',
			data: ['2010', '2011', '2012', '2013', '2014', '2015', '2016', '2017', '2018'],
			splitLine: {
				lineStyle: {
					color: 'rgba(119, 119, 142, 0.2)'
				}
			},
			axisLine: {
				lineStyle: {
					color: 'rgba(119, 119, 142, 0.2)'
				}
			},
			axisLabel: {
				fontSize: 10,
				color: '#9ba6b5'
			}
		},
		series: chartdata3,
		color: ['#ffcf9f', '#9ad0f5']
	};
	var barChart6 = echarts.init(chart6);
	barChart6.setOption(option6);
	window.addEventListener('resize',function(){
        barChart6.resize();
    })

	/*----- Line Chart-03 -----*/
	var chart7 = document.getElementById('echart7');
	var chartdata4 = [{
		name: 'data',
		type: 'line',
		data: [20, 20, 36, 18, 15, 20, 25, 20]
	}];
	var option7 = {
		grid: {
			top: '6',
			right: '0',
			bottom: '17',
			left: '25',
		},
		xAxis: {
			data: ['2011', '2012', '2013', '2014', '2015', '2016', '2017', '2018'],
			axisLine: {
				lineStyle: {
					color: 'rgba(119, 119, 142, 0.2)'
				}
			},
			axisLabel: {
				fontSize: 10,
				color: '#9ba6b5'
			}
		},
		yAxis: {
			splitLine: {
				lineStyle: {
					color: 'rgba(119, 119, 142, 0.2)'
				}
			},
			axisLine: {
				lineStyle: {
					color: 'rgba(119, 119, 142, 0.2)'
				}
			},
			axisLabel: {
				fontSize: 10,
				color: '#9ba6b5'
			}
		},
		series: chartdata4,
		color: ['#b7dd88']
	};
	var lineChart = echarts.init(chart7);
	lineChart.setOption(option7);
	window.addEventListener('resize',function(){
        lineChart.resize();
    })

	/*----- Pie Chart -----*/
	var option8 = {
		title: {
		  text: 'Total Sales',
		  left: 'center'
		},
		tooltip: {
		  trigger: 'item'
		},
		legend: {
		  orient: 'vertical',
		  left: 'left'
		},
		series: [
		  {
			name: 'Access From',
			type: 'pie',
			radius: '50%',
			data: [
			  { value: 1048, name: 'Jan' },
			  { value: 735, name: 'Feb' },
			  { value: 580, name: 'Mar' },
			  { value: 484, name: 'Apr' },
			  { value: 300, name: 'May' }
			],
			emphasis: {
			  itemStyle: {
				shadowBlur: 10,
				shadowOffsetX: 0,
				shadowColor: 'rgba(0, 0, 0, 0.5)'
			  }
			}
		  }
		], 
		color: ['#a4dfdf', '#9ad0f5', '#ffcf9f', '#ffb0c1', '#ffe6aa']
	};
	var chart8 = document.getElementById('echart8');
	var pieChart = echarts.init(chart8);
	pieChart.setOption(option8);
	window.addEventListener('resize',function(){
        pieChart.resize();
    })

	/*----- Pie Chart -----*/
	const data = [];
	for (let i = 0; i < 5; ++i) {
	data.push(Math.round(Math.random() * 200));
	}

	/*---- Bar Chart Race ----*/
	var option9 = {
	xAxis: {
		max: 'dataMax',
		axisLine: {
			lineStyle: {
				color: 'rgba(119, 119, 142, 0.2)'
			}
		},
		axisLabel: {
			fontSize: 10,
			color: '#9ba6b5'
		}
	},
	yAxis: {
		type: 'category',
		data: ['A', 'B', 'C', 'D', 'E'],
		inverse: true,
		animationDuration: 300,
		animationDurationUpdate: 300,
		max: 2, // only the largest 3 bars will be displayed
		axisLine: {
			lineStyle: {
				color: 'rgba(119, 119, 142, 0.2)'
			}
		},
		axisLabel: {
			fontSize: 10,
			color: '#9ba6b5'
		}
	},
	series: [
		{
			realtimeSort: true,
			name: 'X',
			type: 'bar',
			data: data,
			label: {
				show: true,
				position: 'right',
				valueAnimation: true
			}
		}
	],
	color: ['#9ad0f5'],
	legend: {
		show: true
	},
	animationDuration: 0,
	animationDurationUpdate: 3000,
	animationEasing: 'linear',
	animationEasingUpdate: 'linear'
	};
	
	var chart9 = document.getElementById('echart9');
	var pieChart = echarts.init(chart9);
	pieChart.setOption(option9);
	window.addEventListener('resize',function(){
        pieChart.resize();
    })

	function run() {
		for (var i = 0; i < data.length; ++i) {
			if (Math.random() > 0.9) {
				data[i] += Math.round(Math.random() * 2000);
			} else {
				data[i] += Math.round(Math.random() * 200);
			}
		}
		pieChart.setOption({
			series: [
				{
					realtimeSort: true,
					name: 'Data',
					type: 'bar',
					data: data,
					label: {
						show: true,
						position: 'right',
						valueAnimation: true
					}
				}
			],
			
		});
	}
	setTimeout(function () {
		run();
	}, 0);
	setInterval(function () {
		run();
	}, 3000);

	/*---- Bar Chart Animation ----*/
	var xAxisData = [];
	var data1 = [];
	var data2 = [];
	for (var i = 0; i < 100; i++) {
		xAxisData.push('A' + i);
		data1.push((Math.sin(i / 5) * (i / 5 - 10) + i / 6) * 5);
		data2.push((Math.cos(i / 5) * (i / 5 - 10) + i / 6) * 5);
	}
	var option10 = {
		legend: {
		  data: ['bar', 'bar2']
		},
		toolbox: {
		  // y: 'bottom',
		  feature: {
			magicType: {
			  type: ['stack']
			},
			dataView: {},
			saveAsImage: {
			  pixelRatio: 2
			}
		  }
		},
		tooltip: {},
		xAxis: {
		  data: xAxisData,
		  splitLine: {
			show: false
		  },
		  axisLine: {
			lineStyle: {
				color: 'rgba(119, 119, 142, 0.2)'
			}
		  },
		  axisLabel: {
			fontSize: 10,
			color: '#9ba6b5'
		  }
		},
		yAxis: {
			axisLine: {
				lineStyle: {
					color: 'rgba(119, 119, 142, 0.2)'
				}
			},
			axisLabel: {
				fontSize: 10,
				color: '#9ba6b5'
			}
		},
		series: [
		  {
			name: 'bar',
			type: 'bar',
			data: data1,
			emphasis: {
			  focus: 'series'
			},
			animationDelay: function (idx) {
			  return idx * 10;
			}
		  },
		  {
			name: 'bar2',
			type: 'bar',
			data: data2,
			emphasis: {
			  focus: 'series'
			},
			animationDelay: function (idx) {
			  return idx * 10 + 100;
			}
		  }
		],
		color: ['#ffb0c1', '#b7dd88'],
		animationEasing: 'elasticOut',
		animationDelayUpdate: function (idx) {
		  return idx * 5;
		}
	};
	var chart19 = document.getElementById('echart10');
	var areaChart = echarts.init(chart19);
	areaChart.setOption(option10);
	window.addEventListener('resize',function(){
        areaChart.resize();
    })

	/*---- Donut Chart ----*/
	var option11 = {
		tooltip: {
		  trigger: 'item'
		},
		legend: {
		  top: '5%',
		  left: 'center'
		},
		series: [
		  {
			name: 'Access From',
			type: 'pie',
			radius: ['40%', '70%'],
			avoidLabelOverlap: false,
			label: {
			  show: false,
			  position: 'center'
			},
			emphasis: {
			  label: {
				show: true,
				fontSize: '24',
				fontWeight: 'normal'
			  }
			},
			labelLine: {
			  show: false
			},
			data: [
			  { value: 1048, name: 'Data1' },
			  { value: 735, name: 'Data2' },
			  { value: 580, name: 'Data3' },
			  { value: 484, name: 'Data4' },
			  { value: 300, name: 'Data5' }
			]
		  }
		],
		color: ['#a4dfdf', '#9ad0f5', '#ffcf9f', '#ffb0c1', '#ffe6aa']
	};
	var chart20 = document.getElementById('echart11');
	var donutChart = echarts.init(chart20);
	donutChart.setOption(option11);
	window.addEventListener('resize',function(){
        donutChart.resize();
    })
});