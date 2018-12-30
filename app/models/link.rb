class Link < ApplicationRecord
  validate :unique_link

  belongs_to :origin, polymorphic: true
  belongs_to :linkable, polymorphic: true

  def unique_link
    if Link.exists?(origin_id: origin.id, origin_type: origin.model_name.name, linkable_id: linkable.id, linkable_type: linkable.model_name.name) || 
       Link.exists?(origin_id: linkable.id, origin_type: linkable.model_name.name, linkable_id: origin.id, linkable_type: origin.model_name.name)
      errors.add(:Link, "already exists")
    end
  end
end
