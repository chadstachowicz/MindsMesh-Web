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
	htmlresults += "<li><a href=\"/groups/" + data.groups[i].id + "\"><img src=\"https://graph.facebook.com/" + data.groups[i].fb_id + "/picture\"/><u>" + data.groups[i].name + "</u></a></li>";
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
   
    for(i=0;i<data.length;i++){
	htmlresults += "<li><a href=\"#\" data-id=\"" + data[i].id + "\" data-name=\"" + data[i].name + "\" class=\"add_user_message\"><img src=\"https://graph.facebook.com/" + data[i].fb_id + "/picture\"/><u>" + data[i].name + "</u></a></li>";
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
  var sel = "<div id=\"names\" class=\"names\">" + $(this).attr('data-name') + " <a href='#' class='btn btn-mini'>x</a></div>".replace(':c', app1.newpost.files_count++);
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

