App.notifications = App.cable.subscriptions.create("NotificationsChannel", {
  connected: function() {
  },

  disconnected: function() {
  },

  received: function(data) {
    var notification = $(".notification-badge");
    var number_notification = 0;

    if(notification.text() !== "") {
      number_notification = parseInt(notification.text());
    }

    number_notification = number_notification + 1;
    notification.html(number_notification);
    $(".notification-content").prepend(data.content);
  }
});
