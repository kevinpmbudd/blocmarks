class Bookmark < ApplicationRecord
  belongs_to :topic

  validates :url, presence: true
  validates :topic, presence: true
end
