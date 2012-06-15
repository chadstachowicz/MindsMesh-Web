Fabricator(:school_user_request) do
  school
  user
  email { "#{Faker::Internet.user_name}@uncc.edu" }
  confirmation_token nil
  last_email_sent_at nil
end
