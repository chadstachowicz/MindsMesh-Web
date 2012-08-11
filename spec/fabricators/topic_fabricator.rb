Fabricator(:topic) do
  entity
  title { Faker::Lorem.sentence }
  number { rand 9999 }
end
