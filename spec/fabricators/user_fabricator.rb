Fabricator(:user) do
  name { Faker::Name.name }
  gender "male"
  fb_id "12345"
  fb_token "AAAAA"
  fb_expires_at DateTime.yesterday
end