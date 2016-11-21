$(document).on("turbolinks:load ajaxComplete", function() {
  $(".flash-message").delay(3000).fadeOut();
});

$(document).on("turbolinks:load", function() {
  if($("#job-type-post").length > 0) {
    $("#job-type-post").selectize({
      plugins: ["remove_button"]
    });
  }

  if($("#select-country").length > 0) {
    $("#select-country").selectize();
  }
});
