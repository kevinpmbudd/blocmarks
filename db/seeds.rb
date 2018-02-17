require 'faker'

3.times do
  pw = Faker::Internet.password(8)
  User.create!(
    name: Faker::Name.unique.name,
    email: Faker::Internet.unique.email,
    password: pw,
    password_confirmation: pw,
    confirmed_at: Time.now.utc
  )
end

User.create!(
  name: "Kevin",
  email: "kevin@kevinbudd.com",
  password: 'helloworld',
  password_confirmation: 'helloworld',
  confirmed_at: Time.now.utc
)
users = User.all

6.times do
  Topic.create!(
    user: users.sample,
    title: Faker::Science.unique.element
  )
end
topics = Topic.all

24.times do
  Bookmark.create!(
    topic: topics.sample,
    url: "http://google.com"
  )
end

puts "#{User.count} users"
puts "#{Topic.count} topics"
puts "#{Bookmark.count} bookmarks"
