require 'faker'

FactoryBot.define do
  factory :topic do
    title Faker::Science.element
    user 
  end
end
