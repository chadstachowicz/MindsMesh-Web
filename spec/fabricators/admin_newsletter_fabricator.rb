
# MindsMesh, Inc. (c) 2012-2013

Fabricator('Admin::Newsletter') do
  title      { Faker::Lorem.characters 12 }
  plainemail "MyText lorem ipsum dolorem  "
  htmlemail  "<p>MyText lorem ipsum dolorem </p>"
  status     { %w(false true) }
end
