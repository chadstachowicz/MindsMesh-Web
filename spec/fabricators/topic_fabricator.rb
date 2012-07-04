Fabricator(:topic) do
  entity
  name { Faker::Lorem.sentence }
end
