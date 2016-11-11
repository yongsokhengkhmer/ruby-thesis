$(document).on("turbolinks:load ajaxComplete", function() {
  if($("#chats").length > 0) {
    $(".btn-send-message").unbind("click").on("click", function() {
      chat_submit();
    });

    $("#message").unbind("keydown").on("keydown", function(e) {
      if (e.keyCode == 13) {
        chat_submit();
      }
    });

    function chat_submit() {
      var content = $("#message").val();
      var conversation_id = $("#message").data("conversation-id");
      if (content !== "") {
        $.post("/messages", {message: {content: content, conversation_id: conversation_id}});
        $("#message").val("");
      }
    }
  }
});

$(document).on("turbolinks:load", function() {
  if($("#chats").length > 0) {
    $("#receiver-select").selectize();

    $(".person").unbind("click").on("click", function() {
      var conversation_id = $(this).data("conversation");
      var url = "/conversations/" + conversation_id;
      $(".right .chat").html("");
      $(".loading-spin").show();
      history.pushState({conversation_id: conversation_id}, document.title, url);
      $(".person").removeClass("active");
      $(this).addClass("active");
      $.get(url);
    });

    window.addEventListener("popstate", function(e) {
      $.getScript(location.href);
      $(".person").removeClass("active");
      $(".conversation-"+ e.state.conversation_id).addClass("active");
    });
  }
});
