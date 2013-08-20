function adjustBgImage() {
  var width = $(window).width();
  var height = $(window).height();

  var img_width = 1600;
  var img_height = 1064;
  var img = document.getElementById("login_img");

  if (width/height >= img_width/img_height) {
    var temp_height = img_height*width/img_width;
    img.width  = width;
    img.height = temp_height;
    img.style.top = Math.round((height - temp_height) / 2) + 'px';
    img.style.left = 0;    
  } else {
    var temp_width = img_width*height/img_height;
    img.height = height;
    img.width = temp_width;
    img.style.left = Math.round((width - temp_width) / 2) + 'px';
    img.style.top = 0;
  }
}

function fadeInText() {
  var tfade = 1500;
  $('#login_text1').fadeIn(tfade);
  setTimeout(function() {
    $('#login_text2').fadeIn(tfade);
  }, 500);
  setTimeout(function() {
    $('#login_text3').fadeIn(tfade);
  }, 1000);
}