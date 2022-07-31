gr = document.getElementById('graphdiv')
if (screen.width > screen.height) {
  gr.style.height = screen.height/1.4 + 'px';
} else {
  gr.style.height = screen.height/2 + 'px';
}
g.resize()
