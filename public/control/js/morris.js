$(function (e) {
	'use strict';

	//MORRIS BAR2
	new Morris.Area({
		element: 'morrisBar2',

		data: [{
			x: '2010 Q4',
			y: 3,
			z: 7
		}, {
			x: '2011 Q1',
			y: 3,
			z: 4
		}, {
			x: '2011 Q2',
			y: null,
			z: 1
		}, {
			x: '2011 Q3',
			y: 2,
			z: 5
		}, {
			x: '2011 Q4',
			y: 8,
			z: 2
		}, {
			x: '2012 Q1',
			y: 4,
			z: 4
		}],
		xkey: 'x',
		ykeys: ['y', 'z'],
		lineColors: ['#ffb0c1', '#b7dd88'],
		labels: ['Y', 'Z'],
        resize: true
	}).on('click', function (i, row) {
		console.log(i, row);
	});

	// MORRIS BAR3
	new Morris.Area({
		element: 'morrisBar3',
		behaveLikeLine: true,
		data: [{
			x: '2011 Q1',
			y: 3,
			z: 3
		}, {
			x: '2011 Q2',
			y: 2,
			z: 1
		}, {
			x: '2011 Q3',
			y: 2,
			z: 4
		}, {
			x: '2011 Q4',
			y: 3,
			z: 3
		}],
		xkey: 'x',
		ykeys: ['y', 'z'],
		lineColors: ['#ffe6aa', '#9ad0f5'],
		labels: ['Y', 'Z'],
        resize: true
	});

	// MORRIS BAR4
	new Morris.Bar({
		element: 'morrisBar4',
		data: [{
			x: '2011 Q1',
			y: 0
		}, {
			x: '2011 Q2',
			y: 1
		}, {
			x: '2011 Q3',
			y: 2
		}, {
			x: '2011 Q4',
			y: 3
		}, {
			x: '2012 Q1',
			y: 4
		}, {
			x: '2012 Q2',
			y: 5
		}, {
			x: '2012 Q3',
			y: 6
		}, {
			x: '2012 Q4',
			y: 7
		}, {
			x: '2013 Q1',
			y: 8
		}],
		xkey: 'x',
		ykeys: ['y'],
		labels: ['Y'],
        resize: true,
		barColors: function (row, series, type) {
			if (type === 'bar') {
				var red = Math.ceil(0 * row.y / this.ymax);
				return '#ffe6aa';
			} else {
				return '#000';
			}
		}
	});
	var day_data = [{
		"period": "Jan",
		"licensed": 3407,
		"sorned": 660
	}, {
		"period": "Feb",
		"licensed": 3351,
		"sorned": 629
	}, {
		"period": "Mar",
		"licensed": 3269,
		"sorned": 618
	}, {
		"period": "Apr",
		"licensed": 3246,
		"sorned": 661
	}, {
		"period": "May",
		"licensed": 3257,
		"sorned": 667
	}, {
		"period": "June",
		"licensed": 3248,
		"sorned": 627
	}, {
		"period": "July",
		"licensed": 3171,
		"sorned": 660
	}, {
		"period": "Aug",
		"licensed": 3171,
		"sorned": 676
	}, {
		"period": "Sept",
		"licensed": 3201,
		"sorned": 656
	}, {
		"period": "Oct",
		"licensed": 3215,
		"sorned": 622
	}];

	// MORRIS BAR5
	new Morris.Bar({
		element: 'morrisBar5',
		data: day_data,
		xkey: 'period',
		ykeys: ['licensed', 'sorned'],
		labels: ['Licensed', 'SORN'],
		barColors: ['#a4dfdf', '#ffcf9f'],
		xLabelAngle: 0,
        resize: true
	});
	var nReloads = 0;

	function data(offset) {
		var ret = [];
		for (var x = 0; x <= 360; x += 10) {
			var v = (offset + x) % 360;
			ret.push({
				x: x,
				y: Math.sin(Math.PI * v / 180).toFixed(4),
				z: Math.cos(Math.PI * v / 180).toFixed(4)
			});
		}
		return ret;
	}
	// MORRIS BAR6
	var graph = Morris.Line({
		element: 'morrisBar6',
		data: data(0),
		xkey: 'x',
		ykeys: ['y', 'z'],
		labels: ['data1', 'data2'],
        resize: true,
		lineColors: ['#ffb0c1', '#b7dd88'],
		parseTime: false,
		ymin: -1.0,
		ymax: 1.0,
		hideHover: true
	});

	function update() {
		nReloads++;
		graph.setData(data(5 * nReloads));
		$('#reloadStatus').text(nReloads + ' reloads');
	}
	setInterval(update, 100);

	// MORRIS BAR7
	var day_data = [{
		"period": "2012-10-01",
		"licensed": 3407,
		"sorned": 660
	}, {
		"period": "2012-09-30",
		"licensed": 3351,
		"sorned": 629
	}, {
		"period": "2012-09-29",
		"licensed": 3269,
		"sorned": 618
	}, {
		"period": "2012-09-20",
		"licensed": 3246,
		"sorned": 661
	}, {
		"period": "2012-09-19",
		"licensed": 3257,
		"sorned": 667
	}, {
		"period": "2012-09-18",
		"licensed": 3248,
		"sorned": 627
	}, {
		"period": "2012-09-17",
		"licensed": 3171,
		"sorned": 660
	}, {
		"period": "2012-09-16",
		"licensed": 3171,
		"sorned": 676
	}, {
		"period": "2012-09-15",
		"licensed": 3201,
		"sorned": 656
	}, {
		"period": "2012-09-10",
		"licensed": 3215,
		"sorned": 622
	}];
	new Morris.Line({
		element: 'morrisBar7',
		data: day_data,
		xkey: 'period',
		ykeys: ['licensed', 'sorned'],
		labels: ['Licensed', 'SORN'],
		lineColors: ['#ffb0c1', '#9ad0f5'],
        resize: true
	});

	// MORRIS BAR8
	new Morris.Donut({
		element: 'morrisBar8',
		data: [{
			value: 50,
			label: 'data1'
		}, {
			value: 35,
			label: 'data2'
		}, {
			value: 10,
			label: 'data3'
		}],
		backgroundColor: 'rgba(119, 119, 142, 0.2)',
		labelColor: '#77778e',
		colors: ['#b7dd88', '#ffb0c1', '#9ad0f5'],
        resize: true,
		formatter: function (x) {
			return x + "%"
		}
	}).on('click', function (i, row) {
		console.log(i, row);
	});

	//MORRIS BAR9
	new Morris.Donut({
		element: 'morrisBar9',
		data: [{
			value: 35,
			label: 'data1'
		}, {
			value: 25,
			label: 'data2'
		}, {
			value: 15,
			label: 'data3'
		}, {
			value: 15,
			label: 'data4'
		}, {
			value: 10,
			label: 'data5'
		}, {
			value: 10,
			label: 'data6'
		}],
		backgroundColor: 'rgba(119, 119, 142, 0.2)',
		labelColor: '#77778e',
        resize: true,
		colors: ['#a4dfdf', '#9ad0f5', '#ffcf9f', '#ffb0c1', '#ffe6aa', '#b7dd88'],
		formatter: function (x) {
			return x + "%"
		}
	});
});