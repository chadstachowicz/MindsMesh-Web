var $green = '#46A546';
var highlight_options = {color: $green};







app1 = {}
app1.newpost = {
  init:
    function() {

$("form#new_post").live("ajax:success", function(e, data) {
  $("#posts").prepend(data).find(".best_in_place").best_in_place();
  $('.post:first').effect("highlight", highlight_options, 1200);
});


//_new_post

$("#new_post textarea").live("focus", function(e) {
  $(this).switchClass('', 'long', 'fast');
  $('body').addClass('new_post_exposed');
}).live("blur", function(e) {
  $('body').removeClass('new_post_exposed');
});

$("#new_post_create").live('click', function(e) {
  if ($('#new_post textarea').val().length < 10) {
    alert('a reasonable question should have at least 10 letters');
    $('#new_post textarea').focus();
    return;
  }
  if (! $(this).find('#post_topic_user_id').val()) {
    $('#new_post_modal').modal();
  }
});

$(".newpostbutton").live('click', function(e) {
  var tu_id = $(this).data('topic-user-id');
  $("input#post_topic_user_id").val(tu_id);
  $("#new_post").submit();
});

$("#new_post").live("ajax:beforeSend", function(e) {
  $(this).find('textarea').val('');
});

    }
  //end app.newpost.init()
}
//end app.newpost













app1.posts = {
  init:
    function() {

//_post
$(".post_actions a[data-method=delete]").live("ajax:beforeSend", function() {
  $(this).closest(".post").animate({opacity: 0}, "slow", function() {
    $(this).slideUp("fast");
  });
});

//_post -> reply
$(".reply_actions a[data-method=delete]").live("ajax:beforeSend", function() {
  $(this).closest(".reply").animate({opacity: 0}, "slow", function() {
    $(this).slideUp("fast");
  });
});



//_posts
$("#posts a.more").live("ajax:beforeSend", function() {
  $(this).fadeOut('fast');
});
$("#posts a.more").live("ajax:success", function(e, data) {
  $("#posts").append(data).find(".best_in_place").best_in_place();
  $('#posts .posts_pack:last').effect("highlight", highlight_options, 1200);
});

//_post -> new reply

$("form.new_reply textarea").live("focus", function(e) {
  $(this).switchClass('', 'long', 'fast');
});

$("form.new_reply textarea").live("keydown", function(e) {
  if (e.keyCode == 13 && !e.shiftKey && !e.ctrlKey) {
    if (  $.trim($(this).val()).length > 0) {
      $(this).closest('form').submit();
      $(this).val('');
      return false;
    }
  }
});

$("form.new_reply").live("ajax:complete", function(e, data) {
  if (data.status == 200) {
    $(this).closest(".post").find(".replies").append(data.responseText).find(".best_in_place").best_in_place();
    $(this).closest(".post").find(".reply:last").effect("highlight", highlight_options, 1200);
    var c = $(this).closest(".post").find(".reply").length;
    $(this).closest(".post").find(".replybutton span").html(c);
  } else {
    bad_reply =  {e: e, data: data};
    alert("an error #"+data.status+" has occurred.\n\n"+data.responseText);
  }
});

//_reply

$("a[data-scroll-to-reply]").live("click", function() {
  var sel = $(this).data('scroll-to-reply');
  $('body').scrollTo( sel, 'fast', {offset:-150} );
  $(sel).find('textarea').focus();
  return false;
});

//like
$(".likebutton").live("ajax:success", function(e, data) {
  $(this).closest('.post').find(".likebutton span").html(data);
});

    }
  //end app.posts.init()
}
//end app.posts














app1.newpost.init();
app1.posts.init();

//best in place
$(function() {
  $(".best_in_place").best_in_place();
});