
# MindsMesh, Inc. (c) 2012-2013

Fabricator(:admin_newsletters, class_name: :'Admin::Newsletter') do
  title      { Faker::Lorem.characters 12 }
  plainemail "MyText lorem ipsum dolorem  "
  htmlemail  "<p>MyText lorem ipsum dolorem amet</p>"
  status     'true'
end
