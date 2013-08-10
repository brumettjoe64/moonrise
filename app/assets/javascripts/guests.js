function modify_form_info_for(guest_id) {
  var overlay = document.getElementById("overlay_form_info");
  var body = document.getElementsByTagName("body")[0];
  var form = document.getElementById("form_info_"+guest_id); 
  var field = document.getElementById("email_"+guest_id);

  body.style.overflow = "hidden";
  overlay.style.display = "block";
  form.style.display = "block";
  field.focus();
}

function validate_not_empty(field) {
  field_valid = field.value != "";
  if (field_valid) {
    field.parentNode.className = field.parentNode.className.replace(/has-error/g, "");
    return true;
  } else {
    field.parentNode.className = field.parentNode.className + " has-error";
    field.focus();
    return false;
  }
}

function validate_and_switch_to_modify_form_for(this_guest_id, guest_id) {  
  var validated = false;
  var fname_field = document.getElementById("fname_"+this_guest_id);
  var lname_field = document.getElementById("lname_"+this_guest_id);
  var email_field = document.getElementById("email_"+this_guest_id);
  all_valid = validate_not_empty(fname_field) & validate_not_empty(lname_field) & validate_not_empty(email_field);
  if (all_valid) {switch_to_modify_form_for(this_guest_id, guest_id);}
}

function switch_to_modify_form_for(this_guest_id, guest_id) {  
  var this_form = document.getElementById("form_info_"+this_guest_id); 
  var form = document.getElementById("form_info_"+guest_id); 
  var field = document.getElementById("fname_"+guest_id);

  this_form.style.display = "none"; 
  form.style.display = "block"; 
  field.focus();
}

function close_modify_form(button_obj) {
  var overlay = document.getElementById("overlay_form_info");
  var body = document.getElementsByTagName("body")[0];
 
  body.style.overflow = "scroll";
  overlay.style.display = "none";
  button_obj.parentNode.style.display = "none";
}
