jQuery ->
  $("a[rel=popover]").popover()
  #$(".tooltip, a[rel=tooltip], .tooltiped").tooltip({animation: false, placement: 'top'})
  $("#sidebar_left .tooltiped").tooltip({animation: true, placement: 'right'})
  $("#sidebar_right .tooltiped").tooltip({animation: true, placement: 'left'})