$(document).ready(function($) {
element = "#searchAll";
options = '';
var el = this.$element = $(element);
        this.options = $.extend(true, {}, {menu: '<ul class="dropdown-menu"></ul>'}, options);
var menu =  this.$menu = $(this.options.menu).appendTo('body');
        this.shown = false;

 var safeguard = false;
el.keyup(function(){
 var htmlheader = "<li class=\"nav-header\">People</li>";
 var htmlheadergroup = "<li class=\"nav-header\">Groups</li>";
 var htmlresults = htmlheader;
if (el.val() == 0)
{
            menu.hide();
            this.shown = false;
            return this;
} 
$.post("/home/search", { query: el.val() }, function(data) {
   
    for(i=0;i<data.users.length;i++){
	htmlresults += "<li><a href=\"/users/" + data.users[i].id + "\"><img src=\"https://graph.facebook.com/" + data.users[i].fb_id + "/picture\"/><u>" + data.users[i].name + "</u></a></li>";
	}
        htmlresults += htmlheadergroup;
for(i=0;i<data.groups.length;i++){
	htmlresults += "<li><a href=\"/groups/" + data.groups[i].id + "\"><img src=\"https://fbcdn-profile-a.akamaihd.net/static-ak/rsrc.php/v2/yo/r/UlIqmHJn-SK.gif\"/><u>" + data.groups[i].name + "</u></a></li>";
}
            var pos = $.extend({}, el.offset(), {
                height: el[0].offsetHeight,
            });

            menu.css({
                top: 11 + pos.height,
		width: '380'
            });
            menu.insertAfter(el);
            menu.html(htmlresults);
            menu.show();
            this.shown = true;


            return this;

    });



            
});
menu.mouseenter(function(){
safeguard = true;

});
menu.mouseleave(function(){
safeguard = false;
});
$('#searchAll').blur(function() {
    if (safeguard == false){ 
            menu.hide();
            this.shown = false;
            return this;
}
});
});
$(document).ready(function($) {
element = "#peopleToAdd";
options = '';
var el = this.$element = $(element);
        this.options = $.extend(true, {}, {menu: '<ul class="dropdown-menu"></ul>'}, options);
var menu =  this.$menu = $(this.options.menu).appendTo('#messages');
        this.shown = false;

 var safeguard = false;
el.keyup(function(){
 var htmlheader = "<li class=\"nav-header\">People</li>";
 var htmlresults = htmlheader;

if (el.val() == 0)
{
            menu.hide();
            this.shown = false;
            return this;
} 
$.post("/home/search", { query: el.val() }, function(data) {
    for(i=0;i<data.users.length;i++){
	htmlresults += "<li><a href=\"#\" data-id=\"" + data.users[i].id + "\" data-name=\"" + data.users[i].name + 
	  "\" class=\"add_user_message\"><img src=\"https://graph.facebook.com/" + data.users[i].fb_id + "/picture\"/><u>" + data.users[i].name + "</u></a></li>";
	}
            var pos = $.extend({}, el.offset(), {
                height: el[0].offsetHeight,
            });

            menu.css({
                top: 50 + pos.height,
		left: 12,
		width: '250'
            });
            menu.insertAfter(el);
            menu.html(htmlresults);
            menu.show();
            this.shown = true;


            return this;

    });



            
});
$("#messages a.add_user_message").live("click", function() {
  var sel = "<div id=\"names\" value=\"" + $(this).attr('data-id') + "\" class=\"names\">" + $(this).attr('data-name') + " <a href='#' class='btn btn-mini'>x</a></div>".replace(':c', app1.newpost.files_count++);
  $('#question_area_message').append(sel);
  menu.hide();
  this.shown = false;
  el.val("");
  return this;
});

$(".names a").live("click", function() {
  $(this).parent().remove();
  return false;
});
$('#send-mes').live("click", function() {
   var recip_id = [];
   $(".names").each(function() {
    recip_id.push($(this).attr('value'));
   });
   $('#message_receiver_ids').val(recip_id);
   return true;
});
menu.mouseenter(function(){
safeguard = true;

});
menu.mouseleave(function(){
safeguard = false;
});
$('#peopleToAdd').blur(function() {
    if (safeguard == false){ 
            menu.hide();
            this.shown = false;
            return this;
}
});
});
$(document).ready(function($) {
$(".schools-manage a").live("click", function() {
        if (window.confirm("Are you sure you want to delete this?")) {
	     $.post(this.href, {_method:'delete'}, null, "script");
            $(this).parent().remove();
        }
  return false;
});
});
$(document).ready(function($) {
$(".topics-manage a").live("click", function() {
        if (window.confirm("Are you sure you want to delete this?")) {
	     $.post(this.href, {_method:'delete'}, null, "script");
            $(this).parent().remove();
        }
  return false;
});
});
$(document).ready(function($) {
$(".groups-manage a").live("click", function() {
        if (window.confirm("Are you sure you want to delete this?")) {
	     $.post(this.href, {_method:'delete'}, null, "script");
            $(this).parent().remove();
        }
  return false;
});
});
$(document).ready(function($) {
$("#school_role_i").live("change", function() {
        if (window.confirm("Are you sure you want to change this persons role?")) {
	     $.ajax({url: "/entity_users/" +  $(this).attr("name"), type: 'PUT',data:  { entity_user: { role_i: $(this).val()}} });
        }
  return false;
});
});
$(document).ready(function($) {
$("#topic_role_i").live("change", function() {
        if (window.confirm("Are you sure you want to change this persons role?")) {
	     $.ajax({url: "/topic_users/" +  $(this).attr("name"), type: 'PUT',data:  { topic_user: { role_i: $(this).val()}} });
        }
  return false;
});
});
$(document).ready(function($) {
$("#group_role_i").live("change", function() {
        if (window.confirm("Are you sure you want to change this persons role?")) {
	     $.ajax({url: "/group_users/" +  $(this).attr("name"), type: 'PUT',data:  { group_user: { role_i: $(this).val()}} });
        }
  return false;
});
});
