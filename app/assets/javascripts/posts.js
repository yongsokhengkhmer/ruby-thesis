$(document).on("turbolinks:load", function(){
  if ($("#post").length > 0) {
    $("#job-type-post").selectize({
      plugins: ["remove_button"],
      maxItems: 3
    });
    $("#salary").selectize();
    CKEDITOR.replace("post-content");
    $(".ckbox-negotiable").unbind("click").on("click", function() {
      if($(this).is(":checked")) {
        $(".salary-input").hide();
      } else {
        $(".salary-input").show();
      }
    });
  }
});
