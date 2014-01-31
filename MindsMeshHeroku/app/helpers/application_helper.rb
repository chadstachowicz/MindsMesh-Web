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
    ['home#index', 'home#topics', 'users#show', 'topics#show', 'posts#show'].include?(this)
  end

  def localized_short_format(t)
    t.nil? ? 'never' : l(t, format: :short)
  end

  def current_user
      @current_user
  end
  def my_fb_friends_i_should_invite
    is_ie_below_9 = (request.user_agent.include?('MSIE') && !request.user_agent.include?('MSIE 9.0'))
    limit = (is_ie_below_9) ? 25 : 50
    current_user.fb_friends.should_invite.limit(limit)
  end

  def fb_like_button
    %{<script>(function(d, s, id) {
  var js, fjs = d.getElementsByTagName(s)[0];
  if (d.getElementById(id)) return;
  js = d.createElement(s); js.id = id;
  js.src = "//connect.facebook.net/en_US/all.js#xfbml=1&appId=#{Settings.env['facebook']['key']}";
  fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));</script>

<div class="fb-like" data-href="http://www.facebook.com/mindsmesh" data-send="false" data-width="450" data-show-faces="true"></div>}.html_safe
  end
  
end
