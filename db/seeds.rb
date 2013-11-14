
# MindsMesh (c) 2013

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).


User.transaction do
    # if Rails.env.development?
        User.create({name:'Admin Test User', role_1:30, email:'admin@lousianatest.edu', fname: 'Manuel', lname:'Montoya', uname:'aarkerio', active: true, password: 'qwerty78', password_confirmation: 'qwerty78', group_id: 1})
   #end
end

Entity.transaction do

  # if Rails.env.development?
      ls = Array.new
      entities = [
           {name: 'South D Test', state_name: 'SD', domains: '|dakotaunitest.edu|' },
           {name: 'San Antonio Test',  state_name: 'TX', domains: '|sanantoniotest.edu|'},
           {name: 'NYC College Test', state_name: 'NY', domains: '|nytest.edu|'},
           {name: 'North D Test', state_name: 'ND', domains: '|testschool.edu|'},
           {name: 'Charlotte College Test', state_name: 'NC', domains: '|charlottetest.edu|'},
           {name: 'South Testville', state_name: 'SC', domains: '|southcartest.edu|'},
           {name: 'Dakotest College', state_name: 'SD', domains: '|dakotest.edu|'},
           {name: 'UCLA test', state_name: 'CA', domains: '|uclatest.edu|'},
           {name: 'Unin Test Louis', state_name: 'LA', domains: '|lousianatest.edu|'} 
       ]

      entities.each do |k|
          # puts "#{k}  \n"
          ls << ( Entity.create!( k ) )
      end
   
      ls.each { |record| puts record.name.green }

      entity = Entity.find_by_domains('dakotaunitest.edu')
    
      topics = [
          {name: 'Physics 1 (2301-001)', title: 'Title one', number: '111178687' },
          {name: 'Physics 1 (2301-002)', title: 'Title one', number: '7123687'},
          {name: 'Physics 1 (2301-003)', title: 'Title one', number: '767665587'},
          {name: 'Physics for Engineers 2 (2305-001)', title: 'Title one', number: '760998687'},
          {name: 'Physics for Engineers 2 (2305-002)', title: 'Title one', number: '76333687'},
          {name: 'Western Cultures and Chemistry (1341)', title: 'Title one', number: '7222678687'},
          {name: 'Organic Chemistry 1 (0330-001)', title: 'Title one', number: '767111687'},
          {name: 'Organic Chemistry 1 (0330-002)', title: 'Title one', number: '767777687'},
          {name: 'Organic Chemistry 1 (0330-003)', title: 'Title one', number: '7679997'} 
      ]
      ts = Array.new
      topics.each do |t|
          # puts "#{k}  \n"
          ts << ( entity.topics.create!( t ) )
      end
  # end  #  Rails.env.development? ends 
end  # transaction ends

puts "Seeded.".green
puts "Entities: #{Entity.count} | Topic: #{Topic.count}".green

