require 'faker'

FactoryBot.define do
  factory :bookmark do
    url Faker::Internet.url
    topic 
  end
end
