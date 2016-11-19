$(document).on("turbolinks:load", function() {
  if ($("#search").length > 0) {
    var page = 1;

    $("#search #name").unbind("input").on("input", function() {
      page = 1;
      search();
    });

    $("#search #job-type-post, #location").unbind("change").on("change", function() {
      page = 1;
      search();
    });

    function search() {
      var search = $("#search");
      var name = $.trim(search.find("#name").val());
      var job_type_arr = [];
      $("#job-type-post option:selected").each(function(){
        job_type_arr.push(this.text);
      });
      var job_types = job_type_arr.join(" ");
      var location = $.trim(search.find("#location").val());
      $.get("/searches/users", {name: name, job_types: job_types, location: location, page: page})
    }

    $(".user-search-paginate .btn-load-more").unbind("click").bind("click", function() {
      page += 1;
      search();
      $(".user-search-paginate .search-user-spinner").show();
    });
  }
});
