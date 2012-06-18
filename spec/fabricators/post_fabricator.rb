Fabricator(:post) do
  section_user
  section nil
  user nil
  text { Faker::Lorem.sentence }
end
