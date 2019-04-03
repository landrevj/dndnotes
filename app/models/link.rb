class Link < ApplicationRecord
  validate :not_self_referential
  validates :note_id, uniqueness: { scope: :linked_note_id }

  belongs_to :note, touch: true
  belongs_to :linked_note, class_name: 'Note'

  def self.find_link(note_id, other_note_id)
    Link.where('note_id = ? AND linked_note_id = ? OR note_id = ? AND linked_note_id = ?', note_id, other_note_id, other_note_id, note_id).first
  end

  private

  def not_self_referential
    return unless note_id == linked_note_id
    errors.add :link, 'cannot be self-referential.'
  end
end
