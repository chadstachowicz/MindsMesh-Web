$(".post a[data-method=delete]").live "ajax:beforeSend", ->
  $(this).closest(".post").animate(opacity: 0, "slow", -> $(this).slideUp("fast"))