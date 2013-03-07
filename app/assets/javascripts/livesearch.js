$(document).ready(function($) {
element = "#searchAll";
options = '';
var el = this.$element = $(element);
        this.options = $.extend(true, {}, $.fn.typeahead.defaults, options);
var menu =  this.$menu = $(this.options.menu).appendTo('body');
        this.shown = false;
 var safeguard = false;
$("#searchAll").keyup(function(){
 var htmlheader = "<li class=\"nav-header\">People</li>";
 var htmlresults = "";

$.post("/home/search", { query: $('#searchAll').val() }, function(data) {
   
    for(i=0;i<data.length;i++){
	htmlresults += "<li><a href=\"/users/" + data[i].id + "\"><div class\"row\"><img src=\"https://graph.facebook.com/" + data[i].fb_id + "/picture\"/><u>" + data[i].name + "</u></div></a></li>";
	}
            var pos = $.extend({}, el.offset(), {
                height: el[0].offsetHeight,
            });

            menu.css({
                top: pos.top + pos.height,
                left: pos.left,
		width: '400'
            });
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
