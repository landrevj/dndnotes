class Link < ApplicationRecord
  validate :unique_link
  validate :permissions

  validates :origin, presence: true
  validates :linkable, presence: true

  belongs_to :origin, polymorphic: true
  belongs_to :linkable, polymorphic: true
  
  belongs_to :user
  
  def self.find_link(one, another)
    Link.where('origin_id = ? AND origin_type = ? AND linkable_id = ? AND linkable_type = ? OR origin_id = ? AND origin_type = ? AND linkable_id = ? AND linkable_type = ?',
                       one[0],             one[1],         another[0],           another[1],      another[0],         another[1],             one[0],               one[1])
  end

  private

  def unique_link
    # TODO: errors everywhere when invalid 
    unless Link.find_link([origin.id, origin.class.name],[linkable.id, linkable.class.name]).empty?
      errors.add(:Link, "already exists")
    end
  end

  # TODO: do this with cancancan instead if possible
  def permissions
    # check that the user owns both targets of the link
    if origin.user_id != self.user_id || linkable.id != self.user_id
      errors.add( :User, "doesn't own one end of that link")
    end
  end
end
