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

  def image_tag_filename(filename)
    accepted_exts = %w(_page _blank aac css dotx exe hpp java mp3 ods ott png qt sql txt xml aiff bmp dat dwg flv html jpg mp4 odt ppt rar tga wav yml ai c dmg dxf gif ics key mpg otp pdf psd rb tgz xls zip avi cpp doc eps h iso mid odf ots php py rtf tiff xlsx)
    ext = filename.split('.').last
    ext = accepted_exts.first unless accepted_exts.include? ext
    image_tag "/images/file_types/32px/#{ext}.png", width: 32, height: 32
  end

  

end
