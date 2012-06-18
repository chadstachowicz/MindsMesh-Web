# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

user_master = User.first

if user_master.nil?
  puts "you must login with one user, so we can set them as master".red
elsif Course.count > 0
  puts "you already seeded this database".red
else
  School.transaction do
    school = School.create! name: "UNCC"
    
    ls = []

    ls << (c = Course.create! name: 'Physics 1')
    ls << (school.sections.create! name: "#{c.name} / Prof John / Tue 14:00 (section 2301-001)"  do |s|; s.course = c; end)
    ls << (school.sections.create! name: "#{c.name} / Prof Steve / Tue 14:00 (section 2301-002)" do |s|; s.course = c; end)
    
    ls << (c = Course.create! name: 'Physics for Engineers 2')
    ls << (school.sections.create! name: "#{c.name} / Prof Robert / Mon-Wed 10:00 (section 2101-001)" do |s|; s.course = c; end)

    ls << (c = Course.create! name: 'Western Cultures and Chemistry')
    ls << (school.sections.create! name: "#{c.name} / Prof Austin and Prof Cole / Tue-Thu 14:30 (section 3101-001)" do |s|; s.course = c; end)

    ls << (c = Course.create! name: 'Organic Chemistry 1')
    ls << (school.sections.create! name: "#{c.name} / Prof Sandra / Mon 13:00 (section 1209-001)" do |s|; s.course = c; end)
    ls << (school.sections.create! name: "#{c.name} / Prof Sandra / Mon 14:00 (section 1209-002)" do |s|; s.course = c; end)
    ls << (school.sections.create! name: "#{c.name} / Prof Sandra / Mon 15:00 (section 1209-003)" do |s|; s.course = c; end)
    ls << (school.sections.create! name: "#{c.name} / Prof Cole / Tue 13:00 (section 1209-004)"   do |s|; s.course = c; end)

    ls.each { |record| puts record.name.green }

    puts "Seeded.".green
    puts "Users: #{User.count} | Schools: #{School.count} | Course: #{Course.count} | Section: #{Section.count}".green
  end
end