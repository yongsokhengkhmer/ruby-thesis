$(document).on("turbolinks:load", function(){
  if ($("#post").length > 0) {
    $("#job-type-post").selectize();
    CKEDITOR.replace("post-content");
  }
});
