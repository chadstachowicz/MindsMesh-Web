mindsmesh_colors = {
  blue: '#08c',
  green: '#46A546'
}
highlight_options = {color:mindsmesh_colors.green};

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
  $(this).switchClass('', 'long', 1000);
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

// new post / new reply

$("#new_post").live("ajax:success", function(e, data) {
  $("#posts").prepend(data).find(".best_in_place").best_in_place();
  $('.post:first').effect("highlight", highlight_options, 1200);
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

//_new_post

$("#new_post textarea").live("focus", function(e) {
  $(this).switchClass('', 'long', 'fast');
});

$("#new_post").live("ajax:beforeSend", function(e) {
  if ($(this).find('textarea').val().length < 10) {
    alert('a reasonable question should have at least 10 letters');
    $(this).find('textarea').focus();
    return false;
  }
  if (! $(this).find('#topic_user_id').val()) {
    alert('Select a Course');
    $(this).find('#topic_user_id').click();
    return false;
  }
  $(this).find('textarea').val('');
});

//like
$(".likebutton").live("ajax:success", function(e, data) {
  $(this).find("span").html(data);
});

//best in place
$(function() {
  $(".best_in_place").best_in_place();
});