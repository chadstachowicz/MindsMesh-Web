var $green = '#46A546';
var highlight_options = {color: $green};




$('.post').live('mouseover', function() {
  $(this).addClass('hover')
}).live('mouseout', function() {
  $(this).removeClass('hover')
});

$('.caret-down-holder').live('mouseover', function() {
  $(this).addClass('open');
}).live('mouseout', function() {
  $(this).removeClass('open')
});



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
  $(this).closest(".reply").animate({opacity: 0}, "fast", function() {
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



$("a.show_reply_form").live("click", function() {
  $(this).hide().closest('.post').find("form.new_reply").show().find('textarea').focus();
  return false;
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
    $(this).closest(".post").find(".replybutton span").html(c);//TODO: new counter of replies
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
/*
$(".pushpin").live("ajax:success", function(e, data) {
  //$(this).closest('.post').find(".likebutton span").html(data);
  alert('liked')
});
*/
$(".pushpin").live("click", function() {
  var div_post    = $(this).closest('.post');
  var pushpin_on  = div_post.hasClass('pushpin_on');
  var post_id     = div_post.data('id');
  var action      = pushpin_on ? 'unlike' : 'like';
  var url = "/posts/:id/:action".replace(':id', post_id).replace(':action', action);

  $.post(url, function(data) {
    div_post.find('.pins .count').html(data);
    div_post.toggleClass('pushpin_on').toggleClass('pushpin_off');
    pushpin_on  = div_post.hasClass('pushpin_on');


    var cu_id = $.cookie('user_id');

    if (pushpin_on) {
      var template = '<li><a href="/users/:id" data-id=":id" title=":name"><img src=":photo" width="20"></a></li>';
      template  = template.replace(':id', cu_id)
                          .replace(':id', cu_id)
                          .replace(':name',  $.cookie('user_name'))
                          .replace(':photo', $.cookie('user_photo'));
      div_post.find('.pins').prepend(template);
      div_post.find('.pushpin').attr('data-original-title', 'Unpin');
    }
    else
    {
      var sel = ".pins a[data-id=:id]".replace(':id', cu_id);
      div_post.find(sel).closest('li').remove();
      div_post.find('.pushpin').attr('data-original-title', 'Pin');
    }
    


  });

  //$(this).closest('.post').find(".likebutton span").html(data);
  //alert('liked')
  return false;
});

    }
  //end app.posts.init()
}
//end app.posts




app1.newtopic = {
  init:
    function() {

$("form#new_topic").live("ajax:complete", function(e, data) {
  var response = jQuery.parseJSON( data.responseText );
  if (data.status == 201) {
    window.location = "/topics/:slug".replace(':slug', response.slug);
  } else {
    $(this).find('.control-group').removeClass('error2')
    $(this).find('span.help-inline').html('');
    for(error_key in response.errors)
    {
      var sel = "#topic_:class".replace(':class', error_key);
      var div_control_group = $(this).find(sel).closest('.control-group');
      div_control_group.addClass('error2');
      div_control_group.find('span.help-inline').html(response.errors[error_key][0]);
    }
  }
});


TOPIC_FILTER_TIMEOUT_ID = 0;

$("#topics_filter #q").live("keyup", function() {
  


    $("#topics_filter_result").html('');
    $("#topics_filter").addClass('js-filter-on');
  clearTimeout(TOPIC_FILTER_TIMEOUT_ID);
  TOPIC_FILTER_TIMEOUT_ID = setTimeout(function(q) {
    //

    if ($(q).val().length > 0) {


      $("#topics_filter").addClass('js-filter-on');
      var url = "/topics/filter";
      var data = {q: $(q).val()};

      $.ajax({
        url: url,
        data: data,
        success: function(data) {
          $("#topics_filter_result").html(data);
        }
      });

    }
    else
    {
      $("#topics_filter").removeClass('js-filter-on');
    }



    //
  }, 600, this);




});

//js-filter-off

    }
  //end app.newtopic.init()
}
//end app.newtopic










app1.newpost.init();
app1.posts.init();
app1.newtopic.init();

//best in place
$(function() {
  $(".best_in_place").best_in_place();
});