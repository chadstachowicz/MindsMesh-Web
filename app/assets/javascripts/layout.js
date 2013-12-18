$(function() {

  //fix: twitter-bootstrap dropdown for ipad
  $('body').live('touchstart.dropdown', '.dropdown-menu', function (e) { e.stopPropagation(); });

  $("a[rel=popover]").popover()
  //$(".tooltip, a[rel=tooltip], .tooltiped").tooltip({animation: false, placement: 'top'})
  //$("#sidebar_left .tooltiped").tooltip({animation: true, placement: 'right'})
  $("#sidebar_right .tooltiped").tooltip({animation: true, placement: 'left'})
  $(".pushpin").tooltip({animation: true, placement: 'top'})

  $('#main div[data-sidebar]').each(function (i, el) {

    var html = "<td class='sidebar' id='sidebar_%side'>%html</td>";
    html = html.replace('%side', $(this).data('sidebar')).replace('%html', $(el).html());

    var tbl = $("#tablecontent tr:first");

    switch ($(this).data('sidebar')) {
      case 'left':
        tbl.prepend(html);
        break;
      case 'right':
        tbl.append(html);
        break;
      default:
        alert('bad sidebar logic');
        break;
    }
    $(el).remove();
    
  });

});
