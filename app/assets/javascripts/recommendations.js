$(document).on("turbolinks:load", function() {
  if($("#recommendations").length > 0) {
    var page = 1;
    $(".recruiters-paginate .btn-load-more").unbind("click").on("click", function() {
      $(".recommend-spinner").show();
      page++;
      $.get("/recommendations/recruiters", {page: page});
    });

    $(".applicants-paginate .btn-load-more").unbind("click").on("click", function() {
      $(".recommend-spinner").show();
      page++;
      $.get("/recommendations/applicants", {page: page});
    });
  }
});
