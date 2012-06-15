Fabricator(:school_user) do
  school
  user
  b_student false
  b_moderator false
  b_teacher false
  b_admin false
end
