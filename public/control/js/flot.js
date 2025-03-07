'use strict';

var newCust = [
	[0, 2],
	[1, 3],
	[2, 6],
	[3, 5],
	[4, 7],
	[5, 8],
	[6, 10]
];
var retCust = [
	[0, 1],
	[1, 2],
	[2, 5],
	[3, 3],
	[4, 5],
	[5, 6],
	[6, 9]
];
$(function () {
	/*---- line chart-1 ----*/
	var plot = $.plot($('#flotLine1'), [{
		data: newCust,
		label: 'New Customer',
		color: '#77bc21'
	}, {
		data: retCust,
		label: 'Returning Customer',
		color: '#e984b1'
	}], {
		series: {
			lines: {
				show: true,
				lineWidth: 1
			},
			shadowSize: 0
		},
		points: {
			show: false,
		},
		legend: {
			noColumns: 1,
			position: 'nw'
		},
		grid: {
			borderWidth: 1,
			borderColor: 'rgba(171, 167, 167,0.2)',
			hoverable: true
		},
		yaxis: {
			min: 0,
			max: 15,
			color: '#eee',
			tickColor: 'rgba(171, 167, 167,0.2)',
			font: {
				size: 10,
				color: '#999'
			}
		},
		xaxis: {
			color: '#eee',
			tickColor: 'rgba(171, 167, 167,0.2)',
			font: {
				size: 10,
				color: '#999'
			}
		}
	});

	/*---- line chart-2 ----*/
	var plot = $.plot($('#flotLine2'), [{
		data: newCust,
		label: 'New Customer',
		color: '#77bc21'
	}, {
		data: retCust,
		label: 'Returning Customer',
		color: '#e984b1'
	}], {
		series: {
			lines: {
				show: true,
				lineWidth: 1
			},
			shadowSize: 0
		},
		points: {
			show: true,
		},
		legend: {
			noColumns: 1,
			position: 'ne'
		},
		grid: {
			borderWidth: 1,
			borderColor: 'rgba(171, 167, 167,0.2)',
			hoverable: true
		},
		yaxis: {
			min: 0,
			max: 15,
			color: '#eee',
			tickColor: 'rgba(171, 167, 167,0.2)',
			font: {
				size: 10,
				color: '#999'
			}
		},
		xaxis: {
			color: '#eee',
			tickColor: 'rgba(171, 167, 167,0.2)',
			font: {
				size: 10,
				color: '#999'
			}
		}
	});

	/*---- area chart-1 ----*/
	var plot = $.plot($('#flotArea1'), [{
		data: newCust,
		label: 'New Customer',
		color: '#77bc21'
	}, {
		data: retCust,
		label: 'Returning Customer',
		color: '#e984b1'
	}], {
		series: {
			lines: {
				show: true,
				lineWidth: 1,
				fill: true,
				fillColor: {
					colors: [{
						opacity: 0
					}, {
						opacity: 0.8
					}]
				}
			},
			shadowSize: 0
		},
		points: {
			show: false,
		},
		legend: {
			noColumns: 1,
			position: 'nw'
		},
		grid: {
			borderWidth: 1,
			borderColor: 'rgba(171, 167, 167,0.2)',
			hoverable: true
		},
		yaxis: {
			min: 0,
			max: 15,
			color: '#eee',
			tickColor: 'rgba(171, 167, 167,0.2)',
			font: {
				size: 10,
				color: '#999'
			}
		},
		xaxis: {
			color: '#eee',
			tickColor: 'rgba(171, 167, 167,0.2)',
			font: {
				size: 10,
				color: '#999'
			}
		}
	});

	/*---- area chart-2 ----*/
	var plot = $.plot($('#flotArea2'), [{
		data: newCust,
		label: 'New Customer',
		color: '#77bc21'
	}, {
		data: retCust,
		label: 'Returning Customer',
		color: '#e984b1'
	}], {
		series: {
			lines: {
				show: true,
				lineWidth: 1,
				fill: true,
				fillColor: {
					colors: [{
						opacity: 0
					}, {
						opacity: 0.3
					}]
				}
			},
			shadowSize: 0
		},
		points: {
			show: true,
		},
		legend: {
			noColumns: 1,
			position: 'nw'
		},
		grid: {
			borderWidth: 1,
			borderColor: 'rgba(171, 167, 167,0.2)',
			hoverable: true
		},
		yaxis: {
			min: 0,
			max: 15,
			color: '#eee',
			tickColor: 'rgba(171, 167, 167,0.2)',
			font: {
				size: 10,
				color: '#999'
			}
		},
		xaxis: {
			color: '#eee',
			tickColor: 'rgba(171, 167, 167,0.2)',
			font: {
				size: 10,
				color: '#999'
			}
		}
	});

	/*---- bar chart-1 ----*/
	$.plot('#flotBar1', [{
		data: [
			[0, 3],
			[1, 8],
			[2, 5],
			[3, 13],
			[4, 5],
			[5, 7],
			[6, 4],
			[7, 6],
			[8, 3],
			[9, 7]
		]
	}], {
		series: {
			bars: {
				show: true,
				lineWidth: 0,
				fillColor: '#b7dd88',
				barWidth: .8
			},
			highlightColor: '#77bc21'
		},
		grid: {
			borderWidth: 0,
			borderColor: 'rgba(171, 167, 167,0.2)',
			hoverable: true
		},
		yaxis: {
			tickColor: 'rgba(171, 167, 167,0.2)',
			font: {
				color: '#5f6d7a',
				size: 10
			}
		},
		xaxis: {
			tickColor: 'rgba(171, 167, 167,0.2)',
			font: {
				color: '#5f6d7a',
				size: 10
			}
		}
	});

	/*---- bar chart-2 ----*/
	$.plot('#flotBar2', [
		{
			data: [
				[0, 3],
				[2, 8],
				[4, 5],
				[6, 13],
				[8, 5],
				[10, 7],
				[12, 8],
				[14, 10]
			],

			bars: {
				show: true,
				lineWidth: 0,
				fillColor: '#ffdde6',
				barWidth: .3,
			},
			highlightColor: '#ffb6c9'
		},
		{
			data: [
				[1, 5],
				[3, 7],
				[5, 10],
				[7, 7],
				[9, 9],
				[11, 5],
				[13, 4]
			],
			bars: {
				show: true,
				lineWidth: 0,
				fillColor: '#9ad0f5',
				barWidth: .3
			},
			highlightColor: '#76bff1'
		}
	],
		{
			grid: {
				borderWidth: 1,
				borderColor: 'rgba(171, 167, 167,0.2)',
				hoverable: true
			},
			yaxis: {
				tickColor: 'rgba(171, 167, 167,0.2)',
				font: {
					color: '#666',
					size: 10
				}
			},
			xaxis: {
				tickColor: 'rgba(171, 167, 167,0.2)',
				font: {
					color: '#666',
					size: 10
				}
			}
		});

	/*---- Stacking chart ----*/
	var color01 = '#red';
	var color02 = '#blue';
	var color03 = '#green';

	var d1 = [
		{ fillColor: color01 }
	];
	for (var i = 0; i <= 10; i += 1) {
		d1.push([i, parseInt(Math.random() * 30)]);
	}

	var d2 = [
		{ fillColor: color02 }
	];
	for (var i = 0; i <= 10; i += 1) {
		d2.push([i, parseInt(Math.random() * 30)]);
	}

	var d3 = [
		{ fillColor: color03 }
	];
	for (var i = 0; i <= 10; i += 1) {
		d3.push([i, parseInt(Math.random() * 30)]);
	}

	var stack = 0,
		bars = true,
		lines = false,
		steps = false;

	function plotWithOptions() {

		$('#flotStacking').plot(
			[
				{
					color: '#a4dfdf',
					data: d1
				},
				{
					color: '#9ad0f5',
					data: d2
				},
				{
					color: '#ffcf9f',
					data: d3
				}
			],
			{
				series: {
					stack: stack,
					lines: {
						show: lines,
						fill: true,
						steps: steps
					},
					bars: {
						show: bars,
						barWidth: 0.6,
						lineWidth: 2,
					}
				},
				grid: {
					borderWidth: 0,
					borderColor: 'rgba(171, 167, 167,0.2)',
				},
				yaxis: {
					autoScale: "exact",
					tickColor: 'rgba(171, 167, 167,0.2)',
					font: {
						color: '#5f6d7a',
						size: 10
					}
				},
				xaxis: {
					tickColor: 'rgba(171, 167, 167,0.2)',
					font: {
						color: '#5f6d7a',
						size: 10
					}
				}
			}
		);
	}

	plotWithOptions();

	var els = document.querySelectorAll('#control-btn');
	function removeClasses() {
		for (var i = 0; i < els.length; i++) {
			els[i].classList.remove('active')
		}
	}
	var elsA = document.querySelectorAll('#control-btn-stack');
	function removeClassesStack() {
		for (var i = 0; i < elsA.length; i++) {
			elsA[i].classList.remove('active')
		}
	}

	$(".stackControls button").on("click",function (e) {
		e.preventDefault();
		stack = $(this).text() == "With stacking" ? true : null;
		plotWithOptions();
		removeClassesStack();
		this.classList.add('active')
	});

	$(".graphControls button").on("click",function (e) {
		e.preventDefault();
		removeClasses();

		this.classList.add('active')
		bars = $(this).text().indexOf("Bars") != -1;
		lines = $(this).text().indexOf("Lines") != -1;
		steps = $(this).text().indexOf("steps") != -1;
		plotWithOptions();
	});

	/*---- Pie Chart ----*/
	var data = [],
		series = Math.floor(Math.random() * 4) + 3;
	for (var i = 0; i < series; i++) {
		data[i] = {
			label: "Series" + (i + 1),
			data: Math.floor(Math.random() * 100) + 1
		}
	}
	var flotPie = $("#flotPie");
	$("#action-1").on("click", function () {
		flotPie.unbind();
		$("#title").text("Default pie chart");
		$("#description").text("The default pie chart with no options set.");
		$.plot(flotPie, data, {
			series: {
				pie: {
					show: true
				}
			},
			colors: ['#a4dfdf', '#9ad0f5', '#ffcf9f', '#ffb0c1', '#ffe6aa'],
		});
	});
	$("#action-2").on("click", function () {
		flotPie.unbind();
		$("#title").text("Default without legend");
		$("#description").text("The default pie chart when the legend is disabled. Since the labels would normally be outside the container, the chart is resized to fit.");
		$.plot(flotPie, data, {
			series: {
				pie: {
					show: true
				}
			},
			colors: ['#a4dfdf', '#9ad0f5', '#ffcf9f', '#ffb0c1', '#ffe6aa'],
			legend: {
				show: false
			}
		});
	});
	$("#action-3").on("click", function () {
		flotPie.unbind();
		$("#title").text("Custom Label Formatter");
		$("#description").text("Added a semi-transparent background to the labels and a custom labelFormatter function.");
		$.plot(flotPie, data, {
			series: {
				pie: {
					show: true,
					radius: 1,
					label: {
						show: true,
						radius: 1,
						formatter: labelFormatter,
						background: {
							opacity: 0.8
						}
					}
				}
			},
			colors: ['#a4dfdf', '#9ad0f5', '#ffcf9f', '#ffb0c1', '#ffe6aa'],
			legend: {
				show: false
			}
		});
	});
	$("#action-4").on("click", function () {
		flotPie.unbind();
		$("#title").text("Label Radius");
		$("#description").text("Slightly more transparent label backgrounds and adjusted the radius values to place them within the pie.");
		$.plot(flotPie, data, {
			series: {
				pie: {
					show: true,
					radius: 1,
					label: {
						show: true,
						radius: 3 / 4,
						formatter: labelFormatter,
						background: {
							opacity: 0.5
						}
					}
				}
			},
			colors: ['#a4dfdf', '#9ad0f5', '#ffcf9f', '#ffb0c1', '#ffe6aa'],
			legend: {
				show: false
			}
		});
	});
	$("#action-5").on("click", function () {
		flotPie.unbind();
		$("#title").text("Label Styles #1");
		$("#description").text("Semi-transparent, black-colored label background.");
		$.plot(flotPie, data, {
			series: {
				pie: {
					show: true,
					radius: 1,
					label: {
						show: true,
						radius: 3 / 4,
						formatter: labelFormatter,
						background: {
							opacity: 0.5,
							color: "#000"
						}
					}
				}
			},
			colors: ['#a4dfdf', '#9ad0f5', '#ffcf9f', '#ffb0c1', '#ffe6aa'],
			legend: {
				show: false
			}
		});
	});
	$("#action-6").on("click", function () {
		flotPie.unbind();
		$("#title").text("Label Styles #2");
		$("#description").text("Semi-transparent, black-colored label background placed at pie edge.");
		$.plot(flotPie, data, {
			series: {
				pie: {
					show: true,
					radius: 3 / 4,
					label: {
						show: true,
						radius: 3 / 4,
						formatter: labelFormatter,
						background: {
							opacity: 0.5,
							color: "#000"
						}
					}
				}
			},
			colors: ['#a4dfdf', '#9ad0f5', '#ffcf9f', '#ffb0c1', '#ffe6aa'],
			legend: {
				show: false
			}
		});
	});
	$("#action-7").on("click", function () {
		flotPie.unbind();
		$("#title").text("Hidden Labels");
		$("#description").text("Labels can be hidden if the slice is less than a given percentage of the pie (10% in this case).");
		$.plot(flotPie, data, {
			series: {
				pie: {
					show: true,
					radius: 1,
					label: {
						show: true,
						radius: 2 / 3,
						formatter: labelFormatter,
						threshold: 0.1
					}
				}
			},
			colors: ['#a4dfdf', '#9ad0f5', '#ffcf9f', '#ffb0c1', '#ffe6aa'],
			legend: {
				show: false
			}
		});
	});
	$("#action-8").on("click", function () {
		flotPie.unbind();
		$("#title").text("Combined Slice");
		$("#description").text("Multiple slices less than a given percentage (5% in this case) of the pie can be combined into a single, larger slice.");
		$.plot(flotPie, data, {
			series: {
				pie: {
					show: true,
					combine: {
						color: "#999",
						threshold: 0.05
					}
				}
			},
			colors: ['#a4dfdf', '#9ad0f5', '#ffcf9f', '#ffb0c1', '#ffe6aa'],
			legend: {
				show: false
			}
		});
	});
	$("#action-9").on("click", function () {
		flotPie.unbind();
		$("#title").text("Rectangular Pie");
		$("#description").text("The radius can also be set to a specific size (even larger than the container itself).");
		$.plot(flotPie, data, {
			series: {
				pie: {
					show: true,
					radius: 500,
					label: {
						show: true,
						formatter: labelFormatter,
						threshold: 0.1
					}
				}
			},
			colors: ['#a4dfdf', '#9ad0f5', '#ffcf9f', '#ffb0c1', '#ffe6aa'],
			legend: {
				show: false
			}
		});
	});
	$("#action-10").on("click", function () {
		flotPie.unbind();
		$("#title").text("Tilted Pie");
		$("#description").text("The pie can be tilted at an angle.");
		$.plot(flotPie, data, {
			series: {
				pie: {
					show: true,
					radius: 1,
					tilt: 0.5,
					label: {
						show: true,
						radius: 1,
						formatter: labelFormatter,
						background: {
							opacity: 0.8
						}
					},
					combine: {
						color: "#999",
						threshold: 0.1
					}
				}
			},
			colors: ['#a4dfdf', '#9ad0f5', '#ffcf9f', '#ffb0c1', '#ffe6aa'],
			legend: {
				show: false
			}
		});
	});
	$("#action-11").on("click", function () {
		flotPie.unbind();
		$("#title").text("Donut Hole");
		$("#description").text("A donut hole can be added.");
		$.plot(flotPie, data, {
			series: {
				pie: {
					innerRadius: 0.5,
					show: true
				}
			}
		});
	});
	$("#action-1").click();
})

// A custom label formatter used by several of the plots
function labelFormatter(label, series) {
	return "<div style='font-size:8pt; text-align:center; padding:2px; color:white;'>" + label + "<br/>" + Math.round(series.percent) + "%</div>";
}
//
function setCode(lines) {
	$("#code").text(lines.join("\n"));
}

$(function () {
/*---- Area Chart-03 ----*/
var sin = [],
cos = [];
for (var i = 0; i < 14; i += 0.1) {
sin.push([i, Math.sin(i)]);
cos.push([i, Math.cos(i)]);
}
plot = $.plot("#flotArea3", [{
data: sin
}, {
data: cos
}], {
series: {
	lines: {
		show: true,
		lineWidth: 1,
		fill: true,
	},
},

crosshair: {
	mode: "x"
},
grid: {
	borderWidth: 1,
	borderColor: 'rgba(171, 167, 167,0.2)',
},
colors: ['#a4dfdf', '#ffcf9f'],
yaxis: {
	min: -1.2,
	max: 1.2,
	color: '#eee',
	tickColor: 'rgba(171, 167, 167,0.2)',
	font: {
		size: 10,
		color: '#999'
	}
},
xaxis: {
	color: '#eee',
	tickColor: 'rgba(171, 167, 167,0.2)',
	font: {
		size: 10,
		color: '#999'
	}
}
});


// Add the Flot version string to the footer

	/*---- Animating Chart ----*/
	// We use an inline data source in the example, usually data would
	// be fetched from a server
	var data = [],
		totalPoints = 300;

	function getRandomData() {
		if (data.length > 0) data = data.slice(1);
		// Do a random walk
		while (data.length < totalPoints) {
			var prev = data.length > 0 ? data[data.length - 1] : 50,
				y = prev + Math.random() * 10 - 5;
			if (y < 0) {
				y = 0;
			} else if (y > 100) {
				y = 100;
			}
			data.push(y);
		}
		var res = [];
		for (var i = 0; i < data.length; ++i) {
			res.push([i, data[i]])
		}
		return res;
	}
	var updateInterval = 30;
	$("#updateInterval").val(updateInterval).on("change",function () {
		var v = $(this).val();
		if (v && !isNaN(+v)) {
			updateInterval = +v;
			if (updateInterval < 1) {
				updateInterval = 1;
			} else if (updateInterval > 2000) {
				updateInterval = 2000;
			}
			$(this).val("" + updateInterval);
		}
	});
	var plot = $.plot("#flotAnimated", [getRandomData()], {
		series: {
			shadowSize: 0 // Drawing is faster without shadows
		},
		grid: {
			borderColor: "rgba(119, 119, 142, 0.2)",
			borderWidth: 0,
		},
		colors: ["#b7dd88"],
		yaxis: {
			min: 0,
			max: 100,
			tickColor: 'rgba(171, 167, 167,0.2)',
			font: {
				color: '#5f6d7a',
				size: 10
			}
		},
		xaxis: {
			tickColor: 'rgba(171, 167, 167,0.2)',
			font: {
				color: '#5f6d7a',
				size: 10
			}
		}
	});

	function update() {
		plot.setData([getRandomData()]);
		plot.draw();
		setTimeout(update, updateInterval);
	}
	update();

});


