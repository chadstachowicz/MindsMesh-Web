//_posts
$("#posts a.more").live("ajax:beforeSend", function() {
  $(this).fadeOut('fast');
});

//_post -> new reply

$("form.new_reply textarea").live("focus", function(e) {
  $(this).switchClass('', 'long', 1000);
});

$("form.new_reply textarea").live("keydown", function(e) {
  if (e.keyCode == 13 && !e.shiftKey && !e.ctrlKey) {
    if ($(this).val().length < 10) {
      alert('a reasonable reply should have at least 10 letters');
      $(this).focus();
    }
    else {
      $(this).closest('form').submit();
      $(this).val('');
      return false;
    }
  }
});

$("form.new_reply").live("ajax:success", function(e, data) {
  $(this).closest(".post").find(".replies").append(data).find(".best_in_place").best_in_place();
});


//_reply

$("a[data-scroll-to-reply]").live("click", function() {
  var sel = $(this).data('scroll-to-reply');
  $('body').animate({scrollTop: $(sel).offset().top-150}, 1000, function() {
    $(sel).find('textarea').focus();
  });
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
});

//like
$(".likebutton").live("ajax:success", function(e, data) {
  var m = Number($(this).text()) || 0;
  $(this).html( $(this).html().replace(m, data) );
});

//best in place
$(function() {
  $(".best_in_place").best_in_place();
});