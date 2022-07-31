    // options
    {
	labels: ["Date", "1k USD to bitcoin (log scale)"],
	height: "600",
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
