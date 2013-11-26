
# MindsMesh (c) 2013

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

# pass: querty at argentina 
User.transaction do
    # if Rails.env.development?
    # 'school admin'    20,  'student' = 10,          'moderator' = 1
          
    users = [
         {name:'Admin Test User', role_i:30, email:'admin@lousianatest.edu', name: 'Admin User', encrypted_password:'$2a$10$4R.gf6j9AmV4GAgszYVLxeCaoNFiRbsLm0VSM5hoOn0YxD8DNwt2u'},
         {name:'AdminTestUser',role_i:20,email:'scholadmin1@southcartest.edu', name: 'SchoolAdmin', encrypted_password:'$2a$10$4R.gfmV4GAgszYVLxeCaoNFiRbsLm0VDNwt2u'},
         {name:'StudentUser',role_i:10,email:'scholadmin2@sanantoniotest.ed', name: 'SchoolAdmin2', encrypted_password:'$2a$10$4R.gfmV4GAgszYVLxeCaoNFiRbsLm0VDNwt2u'},
         {name:'AdminTestUser',role_i:20,email:'scholadmin3@nytest.edu', name: 'SchoolAdmin3', encrypted_password:'$2a$10$4R.gfmV4GAgszYVLxeCaoNFiRbsLm0VDNwt2u'},
         {name:'StudentUser',role_i:10,email:'scholadmin4@testschool.edu', name: 'Schoolusr2', encrypted_password:'$2a$10$4R.gfmV4GAgszYVLxeCaoNFiRbsLm0VDNwt2u'},
         {name:'studentstUser',role_i:10,email:'scholadmin5@southcartest.edu', name: 'Schooluerts', encrypted_password:'$2a$10$4R.gfmV4GAgszYVLxeCaoNFiRbsLm0VDNwt2u'},
         {name:'adminuser',role_i:20,email:'scholadmin6@charlottetest.edu', name: 'SchooltestAdmin', encrypted_password:'$2a$10$4R.gfmV4GAgszYVLxeCaoNFiRbsLm0VDNwt2u'},
         {name:'studentuser',role_i:10,email:'scholadmin7@charlottetest.edu', name: 'School user', encrypted_password:'$2a$10$4R.gfmV4GAgszYVLxeCaoNFiRbsLm0VDNwt2u'},
         {name:'adminuser',role_i:20,email:'scholadmin8@uclatest.edu', name: 'Aduser', encrypted_password:'$2a$10$4R.gfmV4GAgszYVLxeCaoNFiRbsLm0VDNwt2u'},
         {name:'strudneser',role_i:10,email:'scholusr9@southcartest.edu', name: 'Stunding', encrypted_password:'$2a$10$4R.gfmV4GAgszYVLxeCaoNFiRbsLm0VDNwt2u'},
         {name:'adminuser',role_i:20,email:'scholadmin10@uclatest.edu', name: 'ColleAdmin', encrypted_password:'$2a$10$4R.gfmV4GAgszYVLxeCaoNFiRbsLm0VDNwt2u'},
         {name:'strudneser',role_i:10,email:'scholadmin11@southcartest.edu', name: 'Schooltest', encrypted_password:'$2a$10$4R.gfmV4GAgszYVLxeCaoNFiRbsLm0VDNwt2u'},
         {name:'adminuser',role_i:1,email:'scholmode12@uclatest.edu', name: 'SchoolModera', encrypted_password:'$2a$10$4R.gfmV4GAgszYVLxeCaoNFiRbsLm0VDNwt2u'},
         {name:'strudneser',role_i:1,email:'moder13@southcartest.edu', name: 'SchoolModer', encrypted_password:'$2a$10$4R.gfmV4GAgszYVLxeCaoNFiRbsLm0VDNwt2u'}
           ]
    users.each do |u|
       User.create!(u)
    end
   #end
end

Entity.transaction do

  # if Rails.env.development?
      ls = Array.new
      entities = [
           {name: 'South D Test', state_name: 'SD', domains: '|dakotaunitest.edu|' },
           {name: 'San Antonio Test',  state_name: 'TX', domains: '|sanantoniotest.ed|'},
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

      entity = Entity.find_by_domains('|dakotaunitest.edu|')
      entit2 = Entity.find_by_domains('|nytest.edu|')
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
          # puts "#{t}  \n"
          ts << ( entity.topics.create!( t ) )
          ts << ( entit2.topics.create!( t ) )
      end
  # end  #  Rails.env.development? ends 
end  # transaction ends

# finishing the registration process
EntityUserRequest.transaction do
  EntityUserRequest.attr_accessible :entity_id, :user_id, :email, :confirmation_token, :last_email_sent_at, :confirmed_at
  EntityUserRequest.create({entity_id:1, user_id:1, email:'admin@lousianatest.edu', confirmation_token:'936af849fd007fb57ae7d6593',last_email_sent_at: Time.now,confirmed_at:Time.now})
end 

EntityUser.transaction do
    EntityUser.create({entity_id:1, user_id:1, role_i:30 })
    EntityUser.create({entity_id:1, user_id:2, role_i:20})
    EntityUser.create({entity_id:1, user_id:3, role_i:10 })
    EntityUser.create({entity_id:1, user_id:4, role_i:20 })
    EntityUser.create({entity_id:1, user_id:5, role_i:10})
    EntityUser.create({entity_id:2, user_id:6, role_i:10 })
    EntityUser.create({entity_id:2, user_id:7, role_i:20 })
    EntityUser.create({entity_id:3, user_id:8, role_i:10 })
    EntityUser.create({entity_id:3, user_id:9, role_i:10 })
    EntityUser.create({entity_id:4, user_id:10,role_i:20 })
    EntityUser.create({entity_id:5, user_id:11,role_i:10 })
    EntityUser.create({entity_id:4, user_id:12,role_i:1 })
    EntityUser.create({entity_id:3, user_id:13,role_i:1 })
    EntityUser.create({entity_id:4, user_id:14,role_i:20 })
  end


puts "Seeded.".green
puts "Entities: #{Entity.count} | Topic: #{Topic.count}".green



 

