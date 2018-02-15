class Topic < ApplicationRecord
  belongs_to :user
  has_many :bookmarks

  validates :title, presence: true
  validates :user, presence: true
end
