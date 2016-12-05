$(document).on("turbolinks:load ajaxComplete", function() {
  if($("#chats").length > 0) {
    $(".btn-send-message").unbind("click").on("click", function() {
      chat_submit();
    });

    $("#message").unbind("keydown").on("keydown", function(e) {
      if (e.keyCode == 13) {
        chat_submit();
      }
    });

    $(".attach-file").unbind("click").on("click", function() {
      $(".file-attachment").click();
    });

    $(".attach-image").unbind("click").on("click", function() {
      $(".image-attachment").click();
    });

    $(".file-attachment").unbind("change").on("change", function() {
      if(this.files.length > 0) {
        if(this.files[0].size > 25 * 1048576) { // max size: 25Mb
          alert(I18n.t("chats.messages.file_too_large", {max_size: "25"}));
        } else {
          $(".chat").append("<div class='bubble me uploading-spinner'><i class='fa fa-circle-o-notch fa-spin fa-fw'></i></div>")

          var conversation_id = $("#message").data("conversation-id");
          $("#file-attachment-form").submit();
          set_read(conversation_id);
        }
      }
    });

    $(".image-attachment").unbind("change").on("change", function() {
      if(this.files.length > 0) {
        var ext = $(this).val().split(".").pop().toLowerCase();
        if($.inArray(ext, ["gif","png","jpg","jpeg"]) == -1) {
          alert(I18n.t("chats.messages.invalid_image"));
          return;
        }

        if(this.files[0].size > 2 * 1048576) { // max size: 2Mb
          alert(I18n.t("chats.messages.file_too_large", {max_size: "2"}));
          return;
        }

        $(".chat").append("<div class='bubble me uploading-spinner'><i class='fa fa-circle-o-notch fa-spin fa-fw'></i></div>")

        var conversation_id = $("#message").data("conversation-id");
        $("#image-attachment-form").submit();
        set_read(conversation_id);
      }
    });


    $("#message").unbind("focus").on("focus", function(e) {
      var chat = $(".chat")[0];
      if(chat.scrollTop + chat.offsetHeight == chat.scrollHeight) {
        var conversation_id = $(this).data("conversation-id");
        set_read(conversation_id);
      }
    });

    $(".chat").unbind("slimscroll").bind("slimscroll", function(e, pos) {
      if(pos == "top") {
        var next_url = $(".message-paginate .pagination .next_page a").attr("href");
        if(next_url) {
          $(".message-loading").show();
          $.getScript(next_url);
        }
        return;
      }
    });

    function chat_submit() {
      var content = $("#message").val();
      var conversation_id = $("#message").data("conversation-id");
      var receiver_id = $("#message").data("receiver-id");
      if (content !== "") {
        $.post("/messages", {message: {content: content,
          conversation_id: conversation_id, receiver_id: receiver_id}});
        $("#message").val("");
      }
      set_read(conversation_id);
    }
  }
});

$(document).on("turbolinks:load", function() {
  if($("#chats").length > 0) {
    $("#receiver-select").selectize();

    bind_person_event();

    window.addEventListener("popstate", function(e) {
      $.getScript(location.href);
      $(".person").removeClass("active");
      $(".conversation-"+ e.state.conversation_id).addClass("active");
    });
  }
});

function bind_person_event() {
  $(".person").unbind("click").on("click", function() {
    var conversation_id = $(this).data("conversation");
    var url = "/conversations/" + conversation_id;
    $(".right .chat").html("");
    $(".loading-spin").show();
    history.pushState({conversation_id: conversation_id}, document.title, url);
    $(".person").removeClass("active");
    $(this).addClass("active");
    $.get(url);
  });
}

function set_read(conversation_id) {
  if($(".chat-badge").text() !== "") {
    $(".people .active .preview").removeClass("preview-bold");
    $(".people .active .time").removeClass("time-bold");

    $.ajax({
      type: "PUT",
      url: "/update_read_messages/" + conversation_id,
    });
  }
}
