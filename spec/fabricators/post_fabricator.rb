Fabricator(:post) do
  topic_user
  topic nil
  user nil
  text { Faker::Lorem.sentence }
end
