class Campaign < ApplicationRecord
    include Linkable
    belongs_to :user

    MOTIF_COLOR = 'blue'
end
