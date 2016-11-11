$(document).on("turbolinks:load", function() {
  $(".notification-content").slimScroll({
    height: "350px"
  });

  if($("#chats").length > 0) {
    $(".people").slimScroll({height: "89%"});
    if($(".chat").length > 0) {
      $(".chat").slimScroll({height: "85%"});
      $(".chat").slimScroll({scrollTo: $(".chat")[0].scrollHeight});
    }
  }
});
