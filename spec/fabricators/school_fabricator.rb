Fabricator(:school) do
  name { Faker::Name.name }
  slug { Faker::Internet.user_name }
end
