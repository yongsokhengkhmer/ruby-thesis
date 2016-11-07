$(document).on("turbolinks:load", function() {
  $(".notification-content").slimScroll({
    height: "350px"
  });

  if($("#chats").length > 0) {
    $(".people").slimScroll({height: "89%"});
    $(".chat").slimScroll({height: "85%"});
  }
});
