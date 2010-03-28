require 'faker'

Category.delete_all
Member.delete_all

['Blogger', 'Designer', 'Developer', 'Project Manager', 'SEO Specialist', 'Sysadmin'].each do |category|
  Category.create!(:name => category)
end

50.times do
  member = Member.new
  member.name = Faker::Name.name
  member.email = Faker::Internet.email
  member.url = 'http://' + Faker::Internet.domain_name
  member.active = true
  member.image = File.open(File.join(Rails.root, 'public', 'images', 'avatar.jpg'))
  member.save
end