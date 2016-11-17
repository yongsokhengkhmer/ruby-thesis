$(document).on("turbolinks:load", function() {
  if ($("#search").length > 0) {
    $("#search #name").unbind("input").on("input", function(){
      search();
    });

    $("#search #job-type-post, #location").unbind("change").on("change", function(){
      search();
    });

    function search(){
      var search = $("#search");
      var name = $.trim(search.find("#name").val());
      var job_type_arr = [];
      $("#job-type-post option:selected").each(function(){
        job_type_arr.push(this.text);
      });
      var job_types = job_type_arr.join(" ");
      var location = $.trim(search.find("#location").val());
      $.get("/searches/users", {name: name, job_types: job_types, location: location})
    }
  }
});
