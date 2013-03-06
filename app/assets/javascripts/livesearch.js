$(document).ready(function($) {
var previousValue = $("#search").val();
$("#search").keyup(function(){
    $.post("livesearch", { search: $('#search').val() }, function(data) {
      $("#search_hits").html(data);
    });
  });
});