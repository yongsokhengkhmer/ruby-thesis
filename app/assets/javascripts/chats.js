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

    $("#message").unbind("focus").on("focus", function(e) {
      var chat = $(".chat")[0];
      if(chat.scrollTop + chat.offsetHeight == chat.scrollHeight) {
        var conversation_id = $(this).data("conversation-id");
        set_read(conversation_id);
      }
    });

    function chat_submit() {
      var content = $("#message").val();
      var conversation_id = $("#message").data("conversation-id");
      var receiver_id = $("#message").data("receiver-id");
      if (content !== "") {
        $.post("/messages", {message: {content: content,
          conversation_id: conversation_id, receiver_id: receiver_id}});
        $("#message").val("");
      }
      set_read(conversation_id);
    }
  }
});

$(document).on("turbolinks:load", function() {
  if($("#chats").length > 0) {
    $("#receiver-select").selectize();

    bind_person_event();

    window.addEventListener("popstate", function(e) {
      $.getScript(location.href);
      $(".person").removeClass("active");
      $(".conversation-"+ e.state.conversation_id).addClass("active");
    });
  }
});

function bind_person_event() {
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
}

function set_read(conversation_id) {
  if($(".chat-badge").text() !== "") {
    $(".people .active .preview").removeClass("preview-bold");
    $(".people .active .time").removeClass("time-bold");

    $.ajax({
      type: "PUT",
      url: "/update_read_messages/" + conversation_id,
    });
  }
}
