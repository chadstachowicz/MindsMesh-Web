Fabricator(:notification) do
  user
  b_read false
  action "MyString"
  target { Fabricate(:post) }
  actors_count 1
end
