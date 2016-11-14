$(document).on("turbolinks:load", function() {
  $(".notification-content").slimScroll({
    height: "350px"
  });

  if($("#chats").length > 0) {
    $(".people").slimScroll({height: "89%"});
    if($(".chat").length > 0) {
      set_chat_slimscroll();
    }
  }
});

function set_chat_slimscroll() {
  $(".chat").slimScroll({
    height: "85%",
    start: "bottom"
  });
}
