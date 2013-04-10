$(document).ready(function(){
$("#features_link").click(function() {
     $('html, body').animate({
         scrollTop: $("#features").offset().top
     }, 500);
return false;
 });
$("#schools_link").on('click',function() {
     $('html, body').animate({
         scrollTop: $("#for-schools").offset().top
     }, 500);
return false;
 });

});
function scrollSchools()
{
$('html, body').animate({
         scrollTop: $("#for-schools").offset().top
     }, 500);
return false;
}
