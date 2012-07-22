Fabricator(:notification) do
  user
  b_read false
  action Notification::ACTION_REPLIED
  target { Fabricate(:post) }
  actors_count 1
end
