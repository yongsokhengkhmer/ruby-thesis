$(document).on("turbolinks:load ajaxComplete", function() {
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
});
