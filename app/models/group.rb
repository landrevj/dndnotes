class Group < ApplicationRecord
    include Linkable
    belongs_to :user

    MOTIF_COLOR = 'purple'
end
