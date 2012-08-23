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
  def icon(icon)
    "<i class='icon-#{icon}'></i>".html_safe
  end
  def time_ago(t)
    "#{time_ago_in_words(t)} ago"
  end
  def action_includes_sidebar_right?
    this = "#{controller.controller_name}##{controller.action_name}"
    ['home#index', 'users#show', 'topics#show', 'posts#show'].include?(this)
  end
end
