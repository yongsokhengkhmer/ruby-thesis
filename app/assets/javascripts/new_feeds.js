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

    $(".like-post").unbind("click").on("click", function(){
        activity_id = $(this).data("activity-id");
        $.post("/like_posts", {like_post: {activity_id: activity_id}});
      });

    $(".unlike-post").unbind("click").on("click", function(){
      like_post_id = $(this).data("like-post-id");
      $.ajax({
        url: "/like_posts/" + like_post_id,
        type: "DELETE"
      });
    });
  }
});
