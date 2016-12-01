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

    $(".comments .comment-form textarea").unbind("keydown").on("keydown", function(e){
      if (e.keyCode == 13) {
        var form = $(this).closest(".comment-form");
        var activity_id = form.data("activity-id");
        var content = $.trim($(this).val());
        if (content != "") {
          $.post("/comments", {comment: {activity_id: activity_id,
            content: content}});
        }
      }
    });

    $(".show-comments").unbind("click").on("click", function(){
      var new_feeds = $(this).closest(".new-feeds");
      var comment_count = $(this).find("a").data("count");
      new_feeds.find(".comments-content").show();
      $(this).unbind("click").removeClass("show-comments");
      var new_comment_count = new_feeds.find(".comment-form").data("new-comment-count");

      if (comment_count > 0) {
        var activity_id = new_feeds.find(".comments").data("activity-id");
        new_feeds.find(".comments-spinner").show();
        $.get("/comments", {comment: {activity_id: activity_id}, new_comment_count: new_comment_count});
      }
    });

    $(".load-more").unbind("click").on("click", function(){
      var comment = $(this).closest(".comments");
      var link = comment.find(".pagination .next a").attr("href");
      var activity_id = comment.data("activity-id");
      var new_comment_count = comment.find(".comment-form").data("new-comment-count");
      comment.find(".comments-spinner").show();
      $.get(link, {comment: {activity_id: activity_id}, new_comment_count: new_comment_count});
    });
  }

  $(".post-article").readmore({
    lessLink: "<a href='#'>"+ I18n.t("new_feeds.actions.read_less") +"</a>"
  });
});

$(document).on("turbolinks:load", function() {
  if($(".new-feed-activity").length > 0) {
    $(window).off("scroll").bindWithDelay("scroll", function() {
      if($(window).scrollTop() + $(window).height() > $(document).height() - 300) {
        var next_url = $(".new-feed-load-more .pagination .next_page a").attr("href");
        if(next_url) {
          $(".new-feed-load-more .loading").show();
          $.getScript(next_url);
        }
      }
    }, 300);
  }
});
