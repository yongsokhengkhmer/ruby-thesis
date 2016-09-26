$(document).on("turbolinks:load", function(){
  hide_show_user_profile_field();

  $(".devise-form #user_role").on("change", function(){
    hide_show_user_profile_field();
  });

  function hide_show_user_profile_field() {
    if ($(".devise-form #user_role option:selected").val() == "applicant") {
      $(".gender").show();
    } else {
      $(".gender").hide();
    }
  }
});
