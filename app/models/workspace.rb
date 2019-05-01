class Workspace < ApplicationRecord
  belongs_to :user
  has_many :categories
  validates :name, presence: true
end
