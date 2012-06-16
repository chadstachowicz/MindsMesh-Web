Fabricator(:course) do
  name { Faker::Name.name }
  slug nil
end
