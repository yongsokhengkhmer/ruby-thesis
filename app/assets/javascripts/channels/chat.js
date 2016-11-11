App.chat = App.cable.subscriptions.create("ChatChannel", {
  connected: function() {
  },

  disconnected: function() {
  },

  received: function(data) {
    var chat_body = $("#chats .chat");
    if(chat_body.length > 0) {
      chat_body.append(data.content);
      chat_body.slimScroll({scrollTo: $(".chat")[0].scrollHeight});
    }
  }
});
