class Quest < ApplicationRecord
    include Linkable
    belongs_to :user

    MOTIF_COLOR = 'indigo'
end
