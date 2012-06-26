Fabricator(:post) do
  topic
  user
  text { Faker::Lorem.sentence }
end