class Note < ApplicationRecord
    include Linkable
    belongs_to :user

    MOTIF_COLOR = 'gray'
end
