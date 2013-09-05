$("#entity-email form").live("ajax:complete", function(e, data) {
  $('#entity_request_modal .modal-body h2').html(data.responseText);
  $('#entity_request_modal').modal();
});
$("#new_signup form").live("ajax:complete", function(e, data) {
  $('#signup_request_modal .modal-body h2').html(data.responseText);
  $('#signup_request_modal').modal();
});
$("#dev_signup form").live("ajax:complete", function(e, data) {
  $('#join_entity_modal .modal-body h2').html(data.responseText);
  $('#join_entity_modal').modal();
});

