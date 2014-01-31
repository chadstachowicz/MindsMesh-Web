
# MindsMesh, Inc. (c) 2012-2013

Fabricator(:message) do
  user_id         1
  receiver_id     1
  receiver_fb_id  "MyString"
  text            "MyText"
  replies_count   1
  expired         1
  expiration_date Time.now.to_s
end
