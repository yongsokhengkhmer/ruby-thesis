$(document).on("turbolinks:load ajaxComplete", function() {
  if ($("#search").length > 0) {
    $("#search #name, #location").unbind("input").on("input", function(){
      search();
    });

    $("#search #job-type-post").unbind("change").on("change", function(){
      search();
    });

    function search(){
      var search = $("#search");
      var name = $.trim(search.find("#name").val());
      var job_types = search.find("#job-type-post").val();
      var location = $.trim(search.find("#location").val());
      $.get("/searches/users", {name: name, job_types: job_types, location: location})
    }
  }
});
