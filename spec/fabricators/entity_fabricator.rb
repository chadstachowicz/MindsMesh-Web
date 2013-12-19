Fabricator(:entity) do
  name { Faker::Name.name }
  domains "|uncc.edu|"
  state_name "NC"
end
