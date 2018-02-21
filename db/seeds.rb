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
  user = users.sample

  topic = Topic.create!(
    user: user,
    title: Faker::Science.unique.element
  )

  4.times do
    Bookmark.create!(
      user: user,
      topic: topic,
      url: ["http://google.com", "http://amazon.com", "http://bloc.io", "http://rubyonrails.org"].sample
    )
  end
end
bookmarks = Bookmark.all

12.times do
  Like.create!(
    user: users.sample,
    bookmark: bookmarks.sample
  )
end


puts "#{User.count} users"
puts "#{Topic.count} topics"
puts "#{Bookmark.count} bookmarks"
puts "#{Like.count} likes"
