jQuery ->
  $("a[rel=popover]").popover()
  $(".tooltip, a[rel=tooltip]").tooltip({animation: false, placement: 'left'})