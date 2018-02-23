class Topic < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged
  
  belongs_to :user
  has_many :bookmarks, dependent: :destroy

  validates :title, presence: true
  validates :user, presence: true
end
