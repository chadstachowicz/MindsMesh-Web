Fabricator(:user) do
  name { Faker::Name.name }
  photo_url "MyString"
  roles_s ""
end
