Fabricator(:notify) do
  #this is an invalid fabricator, invoke one of these bellow
end
Fabricator(:notify_post, from: :notify) do
  target { Fabricate(:post) }
end
Fabricator(:notify_reply, from: :notify) do
  target { Fabricate(:reply) }
end
Fabricator(:notify_like, from: :notify) do
  target { Fabricate(:like) }
end
