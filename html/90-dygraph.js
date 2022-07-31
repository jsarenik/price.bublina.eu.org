    // options
    {
	labels: ["Date", "Bitcoin price (USD)"],
	height: "900",
	legend: "always",
	logscale: true,
	labelsDiv: document.getElementById('status'),
	color: "green",
	fillGraph: true,
	yRangePad: 16,
	axes: {
	    y: {
		axisLabelFormatter: formatter,
		valueFormatter: formatter2,
	    },
	},
    }
  );
