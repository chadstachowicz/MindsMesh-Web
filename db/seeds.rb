# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).


Entity.transaction do

  if Entity.count == 0
    entity = Entity.create!(name: "PUBLIC", self_joining: true)
    puts "Created Entity Public".green
    
    entity.topics.create!(name: "General", self_joining: true)
    puts "Created Entity General".green

    Entity.create!(name: "UNCC", self_joining: false)
    puts "Created Entity UNCC".green
  end

  if Rails.env.development?
    ls = []
    entity = Entity.first

    ls << (entity.topics.create! name: 'Physics 1 (2301-001)')
    ls << (entity.topics.create! name: 'Physics 1 (2301-002)')
    ls << (entity.topics.create! name: 'Physics 1 (2301-003)')
    ls << (entity.topics.create! name: 'Physics for Engineers 2 (2305-001)')
    ls << (entity.topics.create! name: 'Physics for Engineers 2 (2305-002)')
    ls << (entity.topics.create! name: 'Western Cultures and Chemistry (1341)')
    ls << (entity.topics.create! name: 'Organic Chemistry 1 (0330-001)')
    ls << (entity.topics.create! name: 'Organic Chemistry 1 (0330-002)')
    ls << (entity.topics.create! name: 'Organic Chemistry 1 (0330-003)')
    ls.each { |record| puts record.name.green }

  end

end
puts "Seeded.".green
puts "Entities: #{Entity.count} | Topic: #{Topic.count}".green