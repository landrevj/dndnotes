class Workspace < ApplicationRecord
  belongs_to :user
  has_many :categories, dependent: :destroy
  has_many :notes, through: :categories
  validates :name, presence: true
end
