    // options
    {
	labels: ["Block", "Bitcoin price (USD)"],
	height: "900",
	legend: "always",
	logscale: true,
	labelsDiv: document.getElementById('status'),
	color: "green",
	fillGraph: true,
	 axes: {
	    y: {
		axisLabelFormatter: formatter,
		valueFormatter: formatter2,
	    },
	},
    }
  );
