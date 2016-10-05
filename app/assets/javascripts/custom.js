$(document).on("turbolinks:load ajaxComplete", function() {
  $(".flash-message").delay(3000).fadeOut();
});
