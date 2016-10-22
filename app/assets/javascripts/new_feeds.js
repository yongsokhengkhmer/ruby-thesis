$(document).on("turbolinks:load ajaxComplete", function() {
  if ($(".new-feeds").length > 0) {
    $(".save-post-action").unbind("click").on("click", function() {
      var activity_id = $(this).data("activity-id");
      $.post("/save_posts", {save_post: {activity_id: activity_id}});
    });

    $(".unsave-post-action").unbind("click").on("click", function() {
      var save_post_id = $(this).data("save-post-id");
      $.ajax({
        url: "/save_posts/" + save_post_id,
        type: "DELETE"
      });
    });

    $(".like-post").unbind("click").on("click", function() {
      activity_id = $(this).data("activity-id");
      $.post("/like_posts", {like_post: {activity_id: activity_id}});
    });

    $(".unlike-post").unbind("click").on("click", function() {
      like_post_id = $(this).data("like-post-id");
      $.ajax({
        url: "/like_posts/" + like_post_id,
        type: "DELETE"
      });
    });

    $(".share-post-action").unbind("click").on("click", function() {
      var post_id = $(this).data("post-id");
      $.get("/share_posts/new", {share_post: {post_id: post_id}});
    });

    $(".comments form").unbind("submit").on("submit", function(){
      var activity_id = $(this).data("activity-id");
      var content = $.trim($(this).find("input").val());
      if (content != "") {
        $.post("/comments", {comment: {activity_id: activity_id,
          content: content}});
      }
    });

    $(".show-comments").unbind("click").on("click", function(){
      var activity_id = $(this).closest(".new-feeds ").find(".comments").data("activity-id");
      $(this).unbind("click").removeClass("show-comments");
      $(".comments-spinner").show();
      $.get("/comments", {comment: {activity_id: activity_id}});
    });

    $(".load-more").unbind("click").on("click", function(){
      var comment = $(this).closest(".comments");
      var link = comment.find(".pagination .next a").attr("href");
      var activity_id = comment.data("activity-id");
      $(".comments-spinner").show();
      $.get(link, {comment: {activity_id: activity_id}});
    });
  }

  $(".post-article").readmore({
    lessLink: "<a href='#'>"+ I18n.t("new_feeds.actions.read_less") +"</a>"
  });
});
