# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

user_master = User.first

if user_master.nil?
  puts "you must login with one user, so we can set them as master".red
elsif Topic.count > 0
  puts "you already seeded this database".red
else
  Entity.transaction do
    entity = Entity.create! name: "UNCC"

    entity.entity_users.create! { |eu| eu.user = user_master }
    
    ls = []

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

    puts "Seeded.".green
    puts "Users: #{User.count} | Entities: #{Entity.count} | Topic: #{Topic.count}".green
  end
end