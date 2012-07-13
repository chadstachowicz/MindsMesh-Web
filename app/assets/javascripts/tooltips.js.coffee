jQuery ->
  $("a[rel=popover]").popover()
  $(".tooltip, a[rel=tooltip], .tooltiped").tooltip({animation: false, placement: 'top'})