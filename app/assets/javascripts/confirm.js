$("#entity-email form").live("ajax:success", function(e, data) {
  $('.modal .modal-body h2').html("A confirmation email has been sent to you.");
  $('.modal').modal();
});

$("#entity-email form").live("ajax:error", function(e, data) {
  $('.modal .modal-body h2').html(data.responseText);
  $('.modal').modal();
});