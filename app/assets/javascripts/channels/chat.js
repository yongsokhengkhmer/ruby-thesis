App.chat = App.cable.subscriptions.create("ChatChannel", {
  connected: function() {
  },

  disconnected: function() {
  },

  received: function(data) {
    if($("#chats")) {
      var chat_body = $("#chats .conversation-chat-"+ data.conversation_id);

      $(".people .conversation-"+ data.conversation_id).remove();
      $(".people").prepend(data.conversation_content);

      if(chat_body.length > 0) {
        var chat = $(".chat")[0];
        $(".people .conversation-"+ data.conversation_id).addClass("active");

        if(chat.scrollTop + chat.offsetHeight == chat.scrollHeight) {
          chat_body.append(data.content);
          chat_body.slimScroll({scrollTo: chat.scrollHeight});
        } else {
          chat_body.append(data.content);
        }
      }

      $(".chat-badge").html(data.unread_conversation);
      bind_person_event();
    }
  }
});
