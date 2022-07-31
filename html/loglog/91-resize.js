      var graphs = [ g ];
      var scales = { x : false, y : false };
      function setLogScale(axis, val) {
        if (axis === 'y') {
          for (var idx = 0; idx < graphs.length; idx++) {
            graphs[idx].updateOptions({ logscale: val });
          }
        } else {
          for (var idx = 0; idx < graphs.length; idx++) {
            graphs[idx].updateOptions({ axes : { x : {  logscale : val } } });
          }
        }
        scales[axis] = val;
        var text = "y: " + (scales.y ? "log" : "linear") + ", x: " + (scales.x ? "log" : "linear");
        document.getElementById("description").innerText = text;
      }
      setLogScale('y', true);
      setLogScale('x', true);
gr = document.getElementById('graphdiv');
if (screen.width > screen.height) {
  gr.style.height = screen.height/1.6 + 'px';
} else {
  gr.style.height = screen.height/2 + 'px';
}
g.resize();
