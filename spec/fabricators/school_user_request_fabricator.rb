Fabricator(:school_user_request) do
  school
  user
  email { Faker::Internet.email_address }
  confirmation_token nil
  last_email_sent_at nil
end
