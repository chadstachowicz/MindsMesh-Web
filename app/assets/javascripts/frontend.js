$(document).ready(function(){
$("#features_link").click(function() {
     $('html, body').animate({
         scrollTop: $("#features").offset().top
     }, 500);
return false;
 });
});
