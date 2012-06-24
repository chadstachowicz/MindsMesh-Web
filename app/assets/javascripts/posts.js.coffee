$(".post_actions a[data-method=delete]").live "ajax:beforeSend", ->
  $(this).closest(".post").animate(opacity: 0, "slow", -> $(this).slideUp("fast"))

$(".reply_actions a[data-method=delete]").live "ajax:beforeSend", ->
  $(this).closest(".reply").animate(opacity: 0, "slow", -> $(this).slideUp("fast"))