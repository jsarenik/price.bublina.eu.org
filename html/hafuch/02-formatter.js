function formatter(y) {
    if (y < 1 )
	return 'B' + y.toFixed(4);
    else if (y < 10 )
	return 'B' + y.toFixed(2);
    else if (y < 1000)
	return 'B' + y.toFixed(0);
    else if (y < 1000 * 1000)
	return 'B' + (y / 1000).toFixed(0) + "k";
    else
	return 'B' + (y / 1000 / 1000).toFixed(0) + "M";
}
function formatter2(y) {
    if (y < 1)
	return 'B' + y.toFixed(8);
    else
	return 'B' + y.toFixed(4);
}
