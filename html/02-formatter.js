function formatter(y) {
    if (y < 0.01)
	return '¢' + (y * 100).toFixed(3);
    else if (y < 1)
	return '¢' + (y * 100).toFixed(0);
    else if (y < 1000)
	return '$' + y.toFixed(0);
    else if (y < 1000 * 1000)
	return '$' + y.toFixed(0)/1000 + "k";
    else if (y < 1000 * 1000 * 1000)
	return '$' + y.toFixed(0)/1000000 + "M";
    else if (y < 1000 * 1000 * 1000 * 1000)
	return '$' + y.toFixed(0)/1000000000 + "G";
}
function formatter2(y) {
    if (y < 1)
	return '$' + y.toFixed(5);
    else
	return '$' + y.toFixed(2);
}
