Fabricator(:topic) do
  entity_user
  title { Faker::Lorem.sentence }
  number { rand 9999 }
end
