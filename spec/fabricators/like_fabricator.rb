Fabricator(:like) do
  user
  likable { Fabricate([:post, :reply].sample) }
end