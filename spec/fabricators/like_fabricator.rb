Fabricator(:like) do
  user
  likable { Fabricate(:post) }
end