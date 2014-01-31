Fabricator(:topic_user) do
  topic
  entity_user { |tu| tu[:topic].entity_user }
  role nil
end
