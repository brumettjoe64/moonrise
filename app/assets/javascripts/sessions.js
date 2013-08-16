function adjustBgImage() {
  var width = window.innerWidth;
  var height = window.innerHeight;
  
  var img_width = 1600;
  var img_height = 1064;
  var img = document.getElementById("login_img");

  if (width/height >= img_width/img_height) {
    img.width  = width;
    var temp_height = img_height*width/img_width;
    img.style.top = Math.round((height - temp_height) / 2) + 'px';    
  } else {
    img.height = height;
    var temp_width = img_width*height/img_height;
    img.style.left = Math.round((width - temp_width) / 2) + 'px';
  }
}

function fadeInText() {
  var tfade = 1500;
  $('#login_text1').fadeIn(tfade,function(){$('#login_text2').fadeIn(tfade,function(){$('#login_text3').fadeIn(tfade)})});  
}