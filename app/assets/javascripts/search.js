$(document).on("turbolinks:load", function() {
  if ($("#search .users-search").length > 0) {
    var page = 1;

    $("#search #name").unbind("input").on("input", function() {
      page = 1;
      search();
    });

    $("#search #job-type-post, #select-country").unbind("change").on("change", function() {
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
      var country = $("#select-country").val();
      $.get("/searches/users", {name: name, job_types: job_types, country: country, page: page})
    }

    $(".user-search-paginate .btn-load-more").unbind("click").bind("click", function() {
      page += 1;
      search();
      $(".user-search-paginate .search-user-spinner").show();
    });
  }

  if ($("#search .jobs-search").length > 0) {
    var page = 1;

    $("#salary-type").selectize();

    $("#search #name").unbind("input").on("input", function() {
      page = 1;
      search();
    });

    $("#search #job-type-post, #select-country, #salary-type").unbind("change").on("change", function() {
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

      var country = $("#select-country").val();
      var salary_type = $("#salary-type").val();

      $.get("/searches/jobs", {name: name, job_types: job_types,
        country: country, salary_type: salary_type, page: page})
    }

    $(".job-search-paginate .btn-load-more").unbind("click").bind("click", function() {
      page += 1;
      search();
      $(".job-search-paginate .search-job-spinner").show();
    });
  }

});
