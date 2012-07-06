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
  def all_other_topics
  	my_topics = current_user.topic_users.map(&:topic_id)
  	Topic.all.select { |t| not my_topics.include?(t.id) }.sort_by(&:name)
  end
end
