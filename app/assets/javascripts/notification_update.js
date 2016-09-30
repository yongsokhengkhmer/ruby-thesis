$(document).on("turbolinks:load", function() {
  $(".dropdown-global").on("click", function(e) {
    var notification_badge = $(".notification-badge");
    if(notification_badge.text() !== "") {
      $(".notification-badge").html("");
      $.ajax({
        type: "PUT",
        url: "/update_seen_notifications"
      });
    }
  });
});
