$("#entity-email form").live("ajax:complete", function(e, data) {
  $('#entity_request_modal .modal-body h2').html(data.responseText);
  $('#entity_request_modal').modal();
});
