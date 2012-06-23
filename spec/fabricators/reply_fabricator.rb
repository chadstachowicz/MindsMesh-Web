Fabricator(:reply) do
  post
  user
  text { Faker::Lorem.sentence }
end
