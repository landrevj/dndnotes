class Note < ApplicationRecord
  belongs_to :user
  belongs_to :category

  has_many :links
  has_many :linked_notes, through: :links
  # has_many :incoming_links, foreign_key: 'linked_note_id', class_name: 'Link'
  # has_many :incoming_linked_notes, through: :incoming_links, source: :note

  validates :name, presence: true
end
