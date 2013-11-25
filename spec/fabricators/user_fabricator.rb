
# MindsMesh, Inc. (c) 2012-2013

Fabricator(:user) do
  name { Faker::Name.name }
  gender "male"
  email {Faker::Internet.email}
  group_id 30
  fb_id "12345"
  fb_token "AAAAA"
  fb_expires_at DateTime.tomorrow
  password { Faker::Lorem.characters 10 }
  password_confirmation { |u| u.password }
end