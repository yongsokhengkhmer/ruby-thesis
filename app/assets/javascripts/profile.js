$(document).on("turbolinks:load", function() {
  set_date_picker($(".input-daterange"));
  set_date_picker($(".date-picker"));
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
