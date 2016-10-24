App.notifications = App.cable.subscriptions.create("ReactionsChannel", {
  connected: function() {
  },

  disconnected: function() {
  },

  received: function(data) {
    var activity = $(".new-feeds-activity-" + data.activity_id);
    var comment_count = activity.find(".comment a");

    var count = (comment_count.data().count += 1);
    comment_count.find(".comment-count").text(" (" + count + ")");

    activity.find(".comment-form").data().newCommentCount += 1;

    var comment_list = activity.find(".comments-list");
    comment_list.append(data.content);
  }
});
