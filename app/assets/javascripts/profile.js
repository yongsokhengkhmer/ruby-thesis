$(document).on("turbolinks:load", function() {
  set_date_picker($(".input-daterange"));
  set_date_picker($(".date-picker"));
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
