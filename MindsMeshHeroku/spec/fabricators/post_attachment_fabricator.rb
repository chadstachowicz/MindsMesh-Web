Fabricator(:post_attachment) do |f|
  f.post
  subtype "MyString"
  link_url "MyString"
end
