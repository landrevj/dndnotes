class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :username, presence: true, uniqueness: true, length: { minimum: 3, maximum: 25 }

  has_many :campaigns, dependent: :destroy
  has_many :links, dependent: :destroy
  has_many :locations, dependent: :destroy
  has_many :notes, dependent: :destroy
  has_many :quests, dependent: :destroy
end
