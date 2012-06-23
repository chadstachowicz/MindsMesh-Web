//_posts
$("#posts a.more").live("ajax:beforeSend", function() {
  $(this).fadeOut('fast');
});

$("form.new_reply textarea").live("focus", function(e) {
  $(this).switchClass('', 'long', 'fast');
});

$("form.new_reply textarea").live("keydown", function(e) {
  if (e.keyCode == 13 && !e.shiftKey && !e.ctrlKey) {
    if ($(this).val().length < 10) {
      alert('a reasonable reply should have at least 10 letters');
      $(this).focus();
    }
    else {
      $(this).closest('form').submit();
    }
  }
});

$("a[data-scroll-to-reply]").live("click", function() {
  var sel = $(this).data('scroll-to-reply');
  $('body').animate({scrollTop: $(sel).offset().top-50}, 'slow', function() {
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