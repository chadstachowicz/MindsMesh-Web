Fabricator(:notification) do
  user
  b_read false
  action Notification::ACTION_REPLIED
  target { Fabricate(:post) }
  actors_count 1
  fb_apprequest_id { rand(9999999) }
end
