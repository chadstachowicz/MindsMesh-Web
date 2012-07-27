$(function() {

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