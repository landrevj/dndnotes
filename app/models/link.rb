class Link < ApplicationRecord
  validate :unique_link

  belongs_to :origin, polymorphic: true
  belongs_to :linkable, polymorphic: true
  
  def self.find_link(one, another)
    Link.where('origin_id=? AND origin_type=? AND linkable_id=? AND linkable_type=? OR origin_id=? AND origin_type=? AND linkable_id=? AND linkable_type=?',
                     one[0],           one[1],       another[0],         another[1],    another[0],       another[1],           one[0],             one[1])
  end

  private

  def unique_link
    if Link.exists?(origin_id: origin.id, origin_type: origin.model_name.name, linkable_id: linkable.id, linkable_type: linkable.model_name.name) || 
       Link.exists?(origin_id: linkable.id, origin_type: linkable.model_name.name, linkable_id: origin.id, linkable_type: origin.model_name.name)
      errors.add(:Link, "already exists")
    end
  end
end
