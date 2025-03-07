$(function () {
	'use strict'

	// LIne-Chart 
	var ctx = document.getElementById("chartLine").getContext('2d');
	var myChart = new Chart(ctx, {
		type: 'line',
		data: {
			labels: ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"],
			datasets: [{
				label: 'Profits',
				data: [100, 420, 210, 420, 210, 320, 350],
				borderWidth: 1,
				backgroundColor: 'transparent',
				borderColor: '#77bc21',
				borderWidth: 1,
				pointBackgroundColor: '#ffffff',
				pointRadius: 3
			}, {
				label: 'Expenses',
				data: [450, 200, 350, 250, 460, 200, 400],
				borderWidth: 1,
				backgroundColor: 'transparent',
				borderColor: '#e984b1',
				borderWidth: 1,
				pointBackgroundColor: '#ffffff',
				pointRadius: 3
			}]
		},
		options: {
			responsive: true,
			maintainAspectRatio: false,

			legend: {
				labels: {
					fontColor: "#77778e"
				},
			},
		}
	});

	// STACKED BAR CHART 
	var ctx6 = document.getElementById('chartStacked1');
	new Chart(ctx6, {
		type: 'bar',
		data: {
			labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'],
			datasets: [{
				data: [10, 24, 20, 25, 35, 50],
				label: 'Dataset 1',
				backgroundColor: '#a4dfdf',
				borderWidth: 0,
				borderColor: '#76bc2100',
				fill: true
			}, {
				data: [10, 24, 20, 25, 35, 50],
				label: 'Dataset 2',
				backgroundColor: '#9ad0f5',
				borderWidth: 0,
				borderColor: '#76bc2100',
				fill: true
			}, {
				data: [20, 30, 28, 33, 45, 65],
				label: 'Dataset 3',
				backgroundColor: '#ffcf9f',
				borderWidth: 0,
				borderColor: '#76bc2100',
				fill: true
			}]
		},
		options: {
			maintainAspectRatio: false,
			legend: {
				display: false,
				labels: {
					display: false
				}
			},
			scales: {
				x: {
					stacked: true,
				},
				y: {
					stacked: true
				}
			}
		}
	});

	// Chart Animation Delay 
	let delayed;
	var ctx11 = document.getElementById('chartDelay');
	new Chart(ctx11, {
		type: 'bar',
		data: {
			labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'],
			datasets: [{
				data: [10, 24, 20, 25, 35, 50],
				label: 'Dataset 1',
				backgroundColor: '#a4dfdf',
				borderWidth: 0,
				borderColor: '#76bc2100',
				fill: true
			}, {
				data: [10, 24, 20, 25, 35, 50],
				label: 'Dataset 2',
				backgroundColor: '#9ad0f5',
				borderWidth: 0,
				borderColor: '#76bc2100',
				fill: true
			}, {
				data: [20, 30, 28, 33, 45, 65],
				label: 'Dataset 3',
				backgroundColor: '#ffcf9f',
				borderWidth: 0,
				borderColor: '#76bc2100',
				fill: true
			}]
		},
		options: {
			maintainAspectRatio: false,
			animation: {
				onComplete: () => {
					delayed = true;
				},
				delay: (context) => {
					let delay = 0;
					if (context.type === 'data' && context.mode === 'default' && !delayed) {
						delay = context.dataIndex * 300 + context.datasetIndex * 100;
					}
					return delay;
				},
			},
			legend: {
				display: false,
				labels: {
					display: false
				}
			},
			scales: {
				x: {
					stacked: true,
				},
				y: {
					stacked: true
				}
			}
		}
	});

	// Chart Animation Progress 
	const data = [];
	const data2 = [];
	let prev = 100;
	let prev2 = 80;
	for (let i = 0; i < 1000; i++) {
		prev += 5 - Math.random() * 10;
		data.push({ x: i, y: prev });
		prev2 += 5 - Math.random() * 10;
		data2.push({ x: i, y: prev2 });
	}
	var ctx = document.getElementById("chartProgress").getContext('2d');
	var myChart = new Chart(ctx, {
		type: 'line',
		data: {
			labels: ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"],
			datasets: [{
				data: data,
				borderWidth: 1,
				backgroundColor: 'transparent',
				borderColor: '#b7dd88',
				borderWidth: 1,
				radius: 0,
			},
			{
				label: 'Expenses',
				data: data2,
				borderWidth: 1,
				backgroundColor: 'transparent',
				borderColor: 'rgba(233, 132, 177, 0.5)',
				borderWidth: 1,
				radius: 0,
			}]
		},
		options: {
			responsive: true,
			maintainAspectRatio: false,
			animation: {
				x: {
					type: 'number',
					easing: 'linear',
					duration: 1000,
					from: NaN, // the point is initially skipped
					delay(ctx) {
						if (ctx.type !== 'data' || ctx.xStarted) {
							return 0;
						}
						ctx.xStarted = true;
						return ctx.index * 5;
					}
				},
				y: {
					type: 'number',
					easing: 'linear',
					duration: 1000,
					from: 0,
					delay(ctx) {
						if (ctx.type !== 'data' || ctx.yStarted) {
							return 0;
						}
						ctx.yStarted = true;
						return ctx.index * 5;
					}
				}
			},
			interaction: {
				intersect: false
			},
			plugins: {
				legend: false
			},
			scales: {
				x: {
					type: 'linear'
				}
			}
		}
	});

	// Chart Animation Drop 
	var ctx = document.getElementById("chartDrop").getContext('2d');
	var myChart = new Chart(ctx, {
		type: 'line',
		data: {
			labels: ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"],
			datasets: [{
				label: 'Profits',
				data: [100, 420, 210, 420, 210, 320, 350],
				animations: {
					y: {
						duration: 2000,
						delay: 500
					}
				},
				backgroundColor: 'transparent',
				borderColor: '#77bc21',
				borderWidth: 1,
				pointBackgroundColor: '#ffffff',
				pointRadius: 3
			}, {
				label: 'Expenses',
				data: [450, 200, 350, 250, 460, 200, 400],
				backgroundColor: 'transparent',
				borderColor: '#e984b1',
				borderWidth: 1,
				pointBackgroundColor: '#ffffff',
				pointRadius: 3
			}]
		},
		options: {
			responsive: true,

			maintainAspectRatio: false,
			animations: {
				y: {
					easing: 'easeInOutElastic',
					from: (ctx) => {
						if (ctx.type === 'data') {
							if (ctx.mode === 'default' && !ctx.dropped) {
								ctx.dropped = true;
								return 0;
							}
						}
					}
				}
			},

			legend: {
				labels: {
					fontColor: "#77778e"
				},
			},
		}
	});

	// Bar-Chart
	var ctx = document.getElementById("chartBar1");
	var myChart = new Chart(ctx, {
		type: 'bar',
		data: {
			labels: ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul"],
			datasets: [{
				label: "Data1",
				data: [65, 59, 80, 81, 56, 55, 40],
				borderColor: "#ffb0c1",
				borderWidth: "0",
				backgroundColor: "#ffb0c1"
			}, {
				label: "Data2",
				data: [28, 48, 40, 19, 86, 27, 90],
				borderColor: "#9ad0f5",
				borderWidth: "0",
				backgroundColor: "#9ad0f5"
			}]
		},
		options: {
			responsive: true,
			maintainAspectRatio: false,
			legend: {
				labels: {
					fontColor: "#77778e"
				},
			},
		}
	});

	// Bar-Chart-02
	var ctx = document.getElementById("chartBar2");
	var myChart = new Chart(ctx, {
		type: 'bar',
		data: {
			labels: ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul"],
			datasets: [{
				label: "Data1",
				data: [-25, -36, 41, 71, -54, -46, 40],
				borderColor: "#ff8fa7",
				borderWidth: "2",
				borderRadius: Number.MAX_VALUE,
				backgroundColor: "#ffb0c1",
				borderSkipped: false,
			}, {
				label: "Data2",
				data: [27, -59, -20, 52, 46, -53, 90],
				borderColor: "#54baff",
				borderWidth: "2",
				borderRadius: 5,
				backgroundColor: "#9ad0f5",
				borderSkipped: false,
			}]
		},
		options: {
			responsive: true,
			maintainAspectRatio: false,
			legend: {
				labels: {
					fontColor: "#77778e"
				},
			},
		}
	});

	// using transparency 
	var ctx3 = document.getElementById('chartBar3').getContext('2d');
	var gradient = ctx3.createLinearGradient(0, 0, 0, 250);
	gradient.addColorStop(0.9, '#4bc0c0');
	gradient.addColorStop(0.7, '#a4dfdf');
	gradient.addColorStop(0.3, '#ffe6aa');
	new Chart(ctx3, {
		type: 'bar',
		data: {
			labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'],
			datasets: [{
				label: '# of Votes',
				data: [12, 39, 20, 10, 25, 18],
				backgroundColor: gradient,
				hoverBackgroundColor: gradient
			}]
		},
		options: {
			maintainAspectRatio: false,
			responsive: true,
			legend: {
				display: false,
				labels: {
					display: false
				}
			},
		}
	});

	// Area Chart
	var ctx9 = document.getElementById('chartArea');
	var gradient1 = ctx3.createLinearGradient(0, 350, 0, 0);
	gradient1.addColorStop(0, 'rgba(232, 170, 152, 0)');
	gradient1.addColorStop(1, 'rgba(255, 192, 203, 1)');
	var gradient2 = ctx3.createLinearGradient(0, 280, 0, 0);
	gradient2.addColorStop(0, 'rgba(70, 236, 185, .0)');
	gradient2.addColorStop(1, 'rgba(89, 173, 236, 0.5)');
	new Chart(ctx9, {
		type: 'line',
		data: {
			labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'July', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
			datasets: [{
				data: [12, 15, 18, 40, 35, 38, 32, 20, 25, 15, 25, 30],
				label: 'dataset 1',
				borderColor: '#f1758a',
				borderWidth: 1,
				backgroundColor: gradient1
			}, {
				data: [10, 20, 25, 55, 50, 45, 35, 37, 45, 35, 55, 40],
				label: 'dataset 2',
				borderColor: '#59adec',
				borderWidth: 1,
				backgroundColor: gradient2
			}]
		},
		options: {
			maintainAspectRatio: false,
			legend: {
				display: false,
				labels: {
					display: false
				}
			},
		}
	});

	// Pie Chart
	var datapie = {
		labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May'],
		datasets: [{
			data: [20, 20, 30, 5, 25],
			backgroundColor: ['#a4dfdf', '#9ad0f5', '#ffcf9f', '#ffb0c1', '#ffe6aa']
		}]
	};
	var optionpie = {
		maintainAspectRatio: false,
		responsive: true,
		legend: {
			display: false,
		},
		animation: {
			animateScale: true,
			animateRotate: true
		}
	};

	// Doughbut Chart
	var ctx6 = document.getElementById('chartPie');
	var myPieChart6 = new Chart(ctx6, {
		type: 'doughnut',
		data: datapie,
		options: optionpie
	});

	// Pie Chart
	var ctx7 = document.getElementById('chartDonut');
	var myPieChart7 = new Chart(ctx7, {
		type: 'pie',
		data: datapie,
		options: optionpie
	});

	// Radar chart
	var ctx = document.getElementById("chartRadar");
	var myChart = new Chart(ctx, {
		type: 'radar',
		data: {
			labels: [

				["Eating", "Dinner"],
				["Drinking", "Water"], "Sleeping", ["Designing", "Graphics"], "Coding", "Cycling", "Running",

			],
			datasets: [{
				label: "Data1",
				data: [65, 59, 66, 45, 56, 55, 40],
				fill: true,
				pointBorderColor: '#fff',
				pointBackgroundColor: '#77bc21',
				pointHoverBackgroundColor: '#fff',
				pointHoverBorderColor: '#77bc21',
				borderColor: "#77bc21",
				borderWidth: "1",
				backgroundColor: "rgba(119, 188, 33, 0.2)"
			}, {
				label: "Data2",
				data: [28, 12, 40, 19, 63, 27, 87],
				fill: true,
				pointBorderColor: '#fff',
				pointBackgroundColor: '#b40e5bcf',
				pointHoverBackgroundColor: '#fff',
				pointHoverBorderColor: '#b40e5bcf',
				borderColor: "#b40e5bcf",
				borderWidth: "1",
				backgroundColor: "rgba(235, 111, 51, 0.2)"
			}]
		},
		options: {
			responsive: true,
			maintainAspectRatio: false,
			legend: {
				display: false
			},
			scale: {
				angleLines: { color: '#77778e' },
				gridLines: {
					color: 'rgba(119, 119, 142, 0.2)'
				},
				ticks: {
					beginAtZero: true,
				},
				pointLabels: {
					fontColor: '#77778e',
				},
			},

		}
	});

	// polar chart 
	var ctx = document.getElementById("chartPolar");
	var myChart = new Chart(ctx, {
		type: 'polarArea',
		data: {
			datasets: [{
				data: [18, 15, 9, 6, 19],
				backgroundColor: ['#a4dfdf', '#9ad0f5', '#ffcf9f', '#ffb0c1', '#ffe6aa'],
				hoverBackgroundColor: ['#87d6d6', '#7fb6db', '#ffbf80', '#ff87a1', '#ffdb85'],
				borderColor: '#fff',
			}],
			labels: ["Data1", "Data2", "Data3", "Data4", "Data5"]
		},
		options: {
			scale: {
				gridLines: {
					color: 'rgba(119, 119, 142, 0.2)'
				}
			},
			responsive: true,
			maintainAspectRatio: false,
			legend: {
				labels: {
					fontColor: "#77778e"
				},
			},
		}
	});

});