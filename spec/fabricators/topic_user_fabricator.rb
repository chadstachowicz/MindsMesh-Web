Fabricator(:topic_user) do
  topic
  user { |tu| Fabricate(:entity_user, entity: tu[:topic].entity).user }
  role nil
end
