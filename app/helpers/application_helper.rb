module ApplicationHelper
  def li(content, options={})
    content_tag(:li, content, options)
  end
  def text_icon(text, icon)
  	"#{text} <i class='icon-#{icon}'></i>".html_safe
  end
  def icon_text(icon, text)
  	"<i class='icon-#{icon}'></i> #{text}".html_safe
  end
end
