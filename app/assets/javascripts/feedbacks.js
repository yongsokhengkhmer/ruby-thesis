$(document).on("turbolinks:load", function(){
  if ($("#feedback-editor").length > 0) {
    CKEDITOR.replace("feedback-editor");
  }
});
