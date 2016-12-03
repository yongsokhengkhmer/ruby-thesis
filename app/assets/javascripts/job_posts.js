$(document).on("turbolinks:load", function() {
  if($("#job-posts").length > 0) {
    var page = 1;
    $(".apply-paginate .load-more").unbind("click").on("click", function() {
      var url = $(location).attr("href");
      $(".apply-spinner").show();
      page++;
      $.get(url, {page: page});
    });
  }
});
