var global_photo_default_pic_url = '/assets/image-blank.png';

function open_photo_display(image_wrapper) {
  var photo = $(image_wrapper).children("img").data("photo");
  $("#overlay_photo_display").show();
  $("#overlay_photo_display").click(function(e) { 
    if ($(e.target).is("#overlay_photo_display")) close_photo_display();
  });

  $("body").css("overflow", "hidden");
  $("#photo_display_caption").text(photo["caption"]);

  var info_text = "taken ";

  if (!photo["where"].match(/^\s*$/)) {
    info_text += "near "+photo["where"]+" · "+moment(photo["when"]).format("MMMM YYYY");
  } else {
    info_text += "in "+moment(photo["when"]).format("MMMM YYYY");
  }
  
  $("#photo_display_info").text(info_text);

  $("#photo_display_time").text(convert_time(photo["created_at"]));
  //$("#photo_display_time").text("Time Now");

  $("#photo_display_poster").text(" posted by "+photo["poster"]);
  $("#photo_display_image").attr("src", photo["image_l"]);
  $("#photo_display_image").data("w", photo["width"]);
  $("#photo_display_image").data("h", photo["height"]);
  //resize_photo_display();
}

function resize_photo_display() {
  var margin_tb = 50;
  var wh = $(window).height()-2*margin_tb;
  var iw = $("#photo_display_image").data("w");
  var ih = $("#photo_display_image").data("h");

  $("#photo_display_image").height(wh);
  $("#content_display_wrapper").height(wh);
  $("#photo_display_wrapper").height(wh);
 
  $("#photo_display_image").width(wh*iw/ih);
  $("#photo_display_wrapper").width($("#photo_display_image").width()+ $("#content_display_wrapper").width());
} 


function close_photo_display() {
  $("#overlay_photo_display").hide();
  $("body").css("overflow", "scroll");
}

function open_photo_form(photo_in_json,thumb_url) {
  var overlay = document.getElementById("overlay_form_photo");
  var body = document.getElementsByTagName("body")[0];
  var form_wrapper = document.getElementById("photo_form_wrapper");
  var legend = document.getElementById("photo_legend");
  var form = document.getElementById("photo_form");
  var field = document.getElementById("photo_field");
  var caption = document.getElementById("photo_caption");
  var tags =  $('[id^=taglist_]');
  var thumb = document.getElementById("photo_preview");
  var month = document.getElementById("photo_when_2i");
  var year = document.getElementById("photo_when_1i");

  clearFileInput(field);

  if (photo_in_json) {
    legend.innerHTML = "Edit Photo";
    form.action = "/photos/"+photo_in_json.id;
    caption.value = photo_in_json.caption;
    thumb.src = thumb_url;
    year.value = (new Date(photo_in_json.when).getFullYear());
    month.value = (new Date(photo_in_json.when).getMonth()+1);
    addSubmitMethodInput();
    for (var i=0; i<tags.length; i++) {
      var tag_id = parseInt(tags[i].id.match(/\d+/)[0]);
      for (var j=0; j<photo_in_json.guests.length; j++) {
        var db_tag_id = photo_in_json.guests[j].id;
        if (tag_id == db_tag_id) {
          tags[i].checked = true;
        }
      }
    }
  } else {
    legend.innerHTML = "Upload Photo";
    form.action = "/photos";
    caption.value = "";
    thumb.src = '/assets/image-blank.png';
    year.value = (new Date().getFullYear());
    month.value = (new Date().getMonth()+1);
    removeSubmitMethodInput();
    for (var i=0; i<tags.length; i++) {
      tags[i].checked = false; 
    }
  }

  global_photo_default_pic_url = thumb.src;
  body.style.overflow = "hidden";
  overlay.style.display = "block";
  form_wrapper.style.display = "block";

}

function close_photo_form() {
  var overlay = document.getElementById("overlay_form_photo");
  var body = document.getElementsByTagName("body")[0];
  var form_wrapper = document.getElementById("photo_form_wrapper");

  body.style.overflow = "scroll";
  overlay.style.display = "none";
  form_wrapper.style.display = "none";
}

function readURL(input) {
  if (input.files && input.files[0]) {
    var reader = new FileReader();
    reader.onload = function (e) {
      $('#photo_preview').attr('src', e.target.result);
    }
    reader.readAsDataURL(input.files[0]);
  } 
}

function reset_default_image() {
  $('#photo_preview').attr('src', global_photo_default_pic_url);
}

function clearFileInput(oldInput) { 
  var newInput = document.createElement("input"); 
  newInput.type = "file"; 
  newInput.id = oldInput.id; 
  newInput.name = oldInput.name; 
  newInput.className = oldInput.className; 
  newInput.style.cssText = oldInput.style.cssText; 
  newInput.onchange = oldInput.onchange;     
  newInput.onclick = oldInput.onclick;
  oldInput.parentNode.replaceChild(newInput, oldInput); 
}

function removeSubmitMethodInput()  {
  var form = document.getElementById("photo_form");
  var method = form.firstChild.getElementsByTagName("_method")[0];
  if (method) { 
    method.parentNode.removeChild(method);
  }
}

function addSubmitMethodInput() {
  var div = document.getElementById("photo_form").firstChild;
  var newInput = document.createElement("input");
  removeSubmitMethodInput();
  newInput.type = "hidden";
  newInput.name = "_method";
  newInput.value = "put";
  div.appendChild(newInput);
}

function validate_and_submit_photo_form() {
  var legend = document.getElementById("photo_legend");
  var field = document.getElementById("photo_field"); 
  
  all_valid = legend.innerHTML == "Edit Photo" || validate_file_exists(field);
  if (all_valid) {return true;} else {return false;}
}

function validate_file_exists(field) {
  field_valid = field.files[0];
  if (field_valid) {
    field.parentNode.className = field.parentNode.className.replace(/has-error/g, "");
    return true;
  } else {
    field.parentNode.className = field.parentNode.className + " has-error";
    return false;
  }
}

function convert_time(inputTime) {
  //console.log(moment(inputTime).fromNow());  
  return moment(inputTime).fromNow();
}