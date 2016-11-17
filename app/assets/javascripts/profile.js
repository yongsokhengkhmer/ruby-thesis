$(document).on("turbolinks:load", function() {
  set_date_picker($(".input-daterange"));
  set_date_picker($(".date-picker"));

  $(".btn-load-more").unbind("click").on("click", function() {
    var next_url = $(".pagination .next_page a").attr("href");
    if(next_url) {
      $(".loading").show();
      $(this).hide();
      $.getScript(next_url);
    }
    return;
  });

  $("#job-type-post").selectize({
    plugins: ["remove_button"]
  });

  $("#location").selectize();
});

$(document).on("turbolinks:load ajaxComplete", function() {
  $(".mark-interest-action").unbind("click").on("click", function() {
    var marked_id = $(this).data("marked-id");
    $.post("/mark_interests", {mark_interest: {marked_id: marked_id}});
  });

  $(".unmark-interest-action").unbind("click").on("click", function() {
    var mark_interest_id = $(this).data("mark-interest-id");
    $.ajax({
      url: "/mark_interests/" + mark_interest_id,
      type: "DELETE"
    });
  });

  $(".follow-action").unbind("click").on("click", function() {
    var followed_id = $(this).data("followed-id");
    $.post("/relationships", {relationship: {followed_id: followed_id}});
  });

  $(".unfollow-action").unbind("click").on("click", function() {
    var relationship_id = $(this).data("relationship-id");
    $.ajax({
      url: "/relationships/" + relationship_id,
      type: "DELETE"
    });
  });
});

$(document).on("nested:fieldAdded", function(event){
  var field = event.field;
  var date_field = field.find(".input-daterange");
  set_date_picker(date_field);
})

function set_date_picker(datepicker) {
  datepicker.datepicker({
    format: "dd-mm-yyyy"
  });
}
