    // options
    {
	labels: ["Date", "bitcoin to USD (linear scale)"],
	height: "600",
	legend: "always",
	logscale: false,
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
