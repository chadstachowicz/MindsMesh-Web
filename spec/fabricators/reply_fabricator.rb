Fabricator(:reply) do |f|
  f.post
  user
  text { Faker::Lorem.sentence }
end