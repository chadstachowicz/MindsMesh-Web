Fabricator(:post) do
  section
  user
  text { Faker::Lorem.sentence }
end
