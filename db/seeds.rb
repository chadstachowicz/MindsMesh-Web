
# MindsMesh (c) 2013

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
    ls = Array.new
    entities = [
       {name: 'Physics 1 (2301-001)', state_name: 'SD', domains: 'dakotaunitest.edu' },
       {name: 'Physics 1 (2301-002)', state_name: 'TX', domains: 'sanantoniotest.edu'},
       {name: 'Physics 1 (2301-003)', state_name: 'NY', domains: 'nytest.edu'},
       {name: 'Physics for Engineers 2 (2305-001)', state_name: 'ND', domains: 'testschool.edu'},
       {name: 'Physics for Engineers 2 (2305-002)', state_name: 'NC', domains: 'charlottetest.edu'},
       {name: 'Western Cultures and Chemistry (1341)', state_name: 'SC', domains: 'southcartest.edu'},
       {name: 'Organic Chemistry 1 (0330-001)', state_name: 'SD', domains: 'dakotest.edu'},
       {name: 'Organic Chemistry 1 (0330-002)', state_name: 'CA', domains: 'uclatest.edu'},
       {name: 'Organic Chemistry 1 (0330-003)', state_name: 'LA', domains: 'lousiana.edu'} 
    ]

    entities.each do |k, v|
       puts "#{k}  is: #{v}"
       ls << ( Entity.create!( v ) )
    end
   
    ls.each { |record| puts record.name.green }

  end

end
puts "Seeded.".green
puts "Entities: #{Entity.count}".green

