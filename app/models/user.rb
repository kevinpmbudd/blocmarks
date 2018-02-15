class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :name,
            length: { minimum: 3, maximum: 100 },
            presence: true

  has_many :topics, dependent: :destroy
end
