module ApplicationHelper
  def li(content, options={})
    content_tag(:li, content, options)
  end
  def text_icon(text, icon)
  	"<span>#{text}</span> <i class='icon-#{icon}'></i>".html_safe
  end
  def icon_text(icon, text)
  	"<i class='icon-#{icon}'></i> <span>#{text}</span>".html_safe
  end
end
