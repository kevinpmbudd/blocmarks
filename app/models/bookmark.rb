class Bookmark < ApplicationRecord
  belongs_to :topic
  belongs_to :user

  validates :url,   presence: true, :url => true 
  validates :topic, presence: true
  validates :user,  presence: true
end
