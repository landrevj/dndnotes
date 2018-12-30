class Link < ApplicationRecord
  belongs_to :origin, polymorphic: true
  belongs_to :linkable, polymorphic: true
end
