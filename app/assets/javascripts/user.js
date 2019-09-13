var boxes = document.querySelectorAll('all_user__contents__link');
var delay = .1; // seconds

var last = boxes[0].offsetTop;
var col = 0;
var row = 0;
for (var i = 0; i < boxes.length; i++) {
  if(boxes[i].offsetTop > last) {
    row = row+1;
    col = 0;
  }
  var last = boxes[i].offsetTop;
  
  boxes[i].style.animationDelay = (row + col) * delay + 's';  
  col = col+1;
}