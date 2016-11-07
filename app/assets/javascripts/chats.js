$(document).on("turbolinks:load", function() {
  if($("#chats").length > 0) {
    $("#receiver-select").selectize();
  }
});
