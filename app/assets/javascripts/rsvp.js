$(document).ready(function() {

  rsvp_initialize_form();

  $("#overlay_form_rsvp").click(function(e) { 
    if ($("#overlay_form_rsvp").data("sent")) {
      rsvp_close_thanks();
    } else if ($(e.target).is("#overlay_form_rsvp") || $(e.target).is(".flipbox-container")) {
      rsvp_close_form();
    } 
  });
});

function rsvp_initialize_form() {
  $(".rsvp_field_go").children(".rsvp_box").click(function(e){ rsvp_click_wedding(this); });
  $(".rsvp_field_nogo").children(".rsvp_box").click(function(e){ rsvp_click_wedding(this); });
  $(".rsvp_field_tea").children(".rsvp_box").click(function(e){ rsvp_click_tea(this); });
  $(".rsvp_field_tea").children(".rsvp_check").click(function(e){ rsvp_click_tea(this); });
  
  $(".rsvp_field_nosurf").click(function(e){ rsvp_click_food(this); });
  $(".rsvp_field_noturf").click(function(e){ rsvp_click_food(this); });  

  $(".rsvp_grp_top").click(function(e){ rsvp_click_up(); });
  $(".rsvp_grp_bot").click(function(e){ rsvp_click_down(); });
  $(".rsvp_grp_submit").click(function(e){ rsvp_sent();});

  $(".rsvp_field_noturf").hover(
    function(){$(this).children(".rsvp_check_text").show();},
    function(){$(this).children(".rsvp_check_text").hide();}
  );
  $(".rsvp_field_nosurf").hover(
    function(){$(this).children(".rsvp_check_text").show();},
    function(){$(this).children(".rsvp_check_text").hide();}
  );

}

function rsvp_open_form() {
  rsvp_load_data();

  $("#overlay_form_rsvp").data("state",0);
  $("#overlay_form_rsvp").data("sent",false);
  $(".rsvp_grp_list").animate({scrollTop:0}, 1);

  $("[id^=rsvp_grp_]").each( function() {
    if ($(this).data("wedding") == "true") {
      $(this).children(".rsvp_grp_main").children(".rsvp_extras").show();
    } else {
      $(this).children(".rsvp_grp_main").children(".rsvp_extras").hide(); 
    }
  });
  rsvp_refresh();
  rsvp_refresh_nav();
  $("#overlay_form_rsvp").show();
  $("body").css("overflow", "hidden");  
}

function rsvp_close_form() {
  $("#overlay_form_rsvp").hide();
  $("body").css("overflow", "auto");
}

function rsvp_close_thanks() {
  rsvp_close_form(); 
  $(".flipbox").flippyReverse();
}

function rsvp_sent() {
  var thanks_text = "";
  if ($("#rsvp_grp_0").data("wedding") == "true") {
    thanks_text = "<div class=\"rsvp_thanks_text ff_title\"> Can't wait to see you at the wedding! </div>";
  } else {
    thanks_text = "<div class=\"rsvp_thanks_text ff_title\"> We'll miss you at the wedding... </div>";
  }
  $(".flipbox").flippy({  
    duration: "500",
    verso: "<div class=\"rsvp_thanks ff_nav\">THANKS FOR REPLYING</div>"+thanks_text,
    direction: "BOTTOM",
    onFinish: function() { $("#overlay_form_rsvp").data("sent",true); },
    onReverseFinish: function() { rsvp_initialize_form(); }
  });
}

function rsvp_click_wedding(box) {
  var rsvp_grp = $(box).parent().parent().parent();
  var box_type = $(box).parent().attr("class");

  if (box_type == "rsvp_field_go") {
    rsvp_grp.data("wedding", "true");
  } else {
    rsvp_grp.data("wedding", "false");
    rsvp_grp.data("tea", "false");
    rsvp_grp.data("nosurf", "false");
    rsvp_grp.data("noturf", "false");
  }
  rsvp_refresh();
}

function rsvp_click_tea(box) {
  var rsvp_grp = $(box).parent().parent().parent().parent();
  var box_val  = rsvp_grp.data("tea");
  rsvp_grp.data("tea", (box_val == "true") ? "false" : "true" ); 
  rsvp_refresh();
}

function rsvp_click_food(box) {
  var rsvp_grp = $(box).parent().parent().parent().parent();
  var food_type = $(box).attr("class").match(/rsvp_field\S+/)[0].match(/[A-Za-z]+$/)[0];
  var food_val = rsvp_grp.data(food_type);
  rsvp_grp.data(food_type, (food_val == "true") ? "false" : "true" ); 
  rsvp_refresh();
}

function rsvp_click_down() {
  var pos = $(".rsvp_grp_list").scrollTop();
  var state = $("#overlay_form_rsvp").data("state");
  $("#overlay_form_rsvp").data("state", state+1); 
  //$(".rsvp_grp_bot").hide();
  $(".rsvp_grp_list").animate({ scrollTop: pos+200}, 500, function(){ rsvp_refresh_nav();});
}

function rsvp_click_up() {
  var pos = $(".rsvp_grp_list").scrollTop();
  var state = $("#overlay_form_rsvp").data("state");  
  $("#overlay_form_rsvp").data("state", state-1);
  //$(".rsvp_grp_bot").hide();
  $(".rsvp_grp_list").animate({ scrollTop: pos-200}, 500, function(){ rsvp_refresh_nav();});
}

function rsvp_validate_and_save() {
  $("[id^=rsvp_grp_]").each( function() {
    var wedding_field  = $(this).find("[id^=wedding_]");
    var tea_field  = $(this).find("[id^=tea_]");
    var nosurf_field  = $(this).find("[id^=nosurf_]");
    var noturf_field  = $(this).find("[id^=noturf_]");
    wedding_field.val($(this).data("wedding"));
    tea_field.val($(this).data("tea"));
    nosurf_field.val($(this).data("nosurf"));
    noturf_field.val($(this).data("noturf"));
  });
  $("#overlay_form_rsvp").find('form').submit();
}

function rsvp_load_data() {
  $("[id^=rsvp_grp_]").each( function() {
    var wedding_field  = $(this).find("[id^=wedding_]");
    var tea_field  = $(this).find("[id^=tea_]");
    var nosurf_field  = $(this).find("[id^=nosurf_]");
    var noturf_field  = $(this).find("[id^=noturf_]");
    $(this).data("wedding", wedding_field.val());
    $(this).data("tea", tea_field.val());
    $(this).data("nosurf", nosurf_field.val());
    $(this).data("noturf", noturf_field.val()); 
  });
}

function rsvp_refresh_nav() {
  var state = $("#overlay_form_rsvp").data("state"); 
  var last = $("[id^=rsvp_grp_]").length-1;

  if ((state==0) && (state==last)) {
    $(".rsvp_grp_top").hide();
    $(".rsvp_grp_bot").hide();
    $(".rsvp_grp_submit").show();
  } else if (state == 0) {
    $(".rsvp_grp_top").hide();
    $(".rsvp_grp_bot").show();
    $(".rsvp_grp_submit").hide();
  } else if (state >= last) {
    //Hack for clicking too fast
    $("#overlay_form_rsvp").data("state", last); 
    $(".rsvp_grp_top").show();
    $(".rsvp_grp_bot").hide();
    $(".rsvp_grp_submit").show();
  } else {
    $(".rsvp_grp_top").show();
    $(".rsvp_grp_bot").show();
    $(".rsvp_grp_submit").hide();
  }
}

function rsvp_refresh() {
  $("[id^=rsvp_grp_]").children(".rsvp_grp_main").each( function() {
    var rsvp_grp = $(this).parent();
    var rsvp_field_go = $(this).find(".rsvp_field_go");
    var rsvp_field_nogo = $(this).find(".rsvp_field_nogo");
    var rsvp_field_tea = $(this).find(".rsvp_field_tea");
    var rsvp_field_nosurf = $(this).find(".rsvp_field_nosurf");
    var rsvp_field_noturf = $(this).find(".rsvp_field_noturf");
    if ($(rsvp_grp).data("wedding") == "nil") {
      //console.log("No reply yet");
      rsvp_field_go.children(".rsvp_check").hide();
      rsvp_field_nogo.children(".rsvp_check").hide();
      $(this).children(".rsvp_extras").fadeOut();
      rsvp_complete = false;
    } else if ($(rsvp_grp).data("wedding") == "true") {
      //console.log("Gladly accepts");
      rsvp_field_go.children(".rsvp_check").show();
      rsvp_field_nogo.children(".rsvp_check").hide();
      $(this).children(".rsvp_extras").fadeIn();
    } else {
      //console.log("Sadly declines");
      rsvp_field_go.children(".rsvp_check").hide();
      rsvp_field_nogo.children(".rsvp_check").show();
      $(this).children(".rsvp_extras").fadeOut();
    }
    ($(rsvp_grp).data("tea") == "true") ? rsvp_field_tea.children(".rsvp_check").show() : rsvp_field_tea.children(".rsvp_check").hide();
    ($(rsvp_grp).data("nosurf") == "true") ? rsvp_field_nosurf.children(".rsvp_check_food").show() : rsvp_field_nosurf.children(".rsvp_check_food").hide();
    ($(rsvp_grp).data("noturf") == "true") ? rsvp_field_noturf.children(".rsvp_check_food").show() : rsvp_field_noturf.children(".rsvp_check_food").hide();    
  });

  rsvp_validate_and_save();
  //if (rsvp_complete) {$("#rsvp_submit").show();}
}
