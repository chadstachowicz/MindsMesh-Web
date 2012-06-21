Fabricator(:entity_user_request) do
  entity
  user
  email { "#{Faker::Internet.user_name}@uncc.edu" }
  confirmation_token nil
  last_email_sent_at nil
end
