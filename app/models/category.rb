class Category < ApplicationRecord
    belongs_to :user
    has_many :notes, dependent: :destroy

    validates :name, presence: true
end
