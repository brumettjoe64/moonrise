function open_blog_display(image_wrapper) {
  var blog = $(image_wrapper).children(".image_wrapper").children("img").data("blog");
  $("#overlay_blog_display").show();
  $("#overlay_blog_display").click(function(e) { 
    if ($(e.target).is("#overlay_blog_display")) close_blog_display();
  });

  $("body").css("overflow", "hidden");
  $("#blog_display_title").text(blog["title"]);
  $("#blog_display_body").text(blog["body"]);
  $("#blog_display_image").attr("src", blog["image_l"]);
  $("#blog_display_date").text(" "+moment(blog["when"]).format("M/DD/YYYY"));
  $("#blog_display_poster").text(blog["poster"].split(" ")[0][0]+blog["poster"].split(" ")[1][0].toLowerCase());
  console.log(blog["poster"].split(" ")[0][0]);
//  console.log(blog["poster"].split[" "][0]);

}

function close_blog_display() {
  $("#overlay_blog_display").hide();
  $("body").css("overflow", "auto");
}
