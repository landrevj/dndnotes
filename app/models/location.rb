class Location < ApplicationRecord
    include Linkable
    belongs_to :user

    MOTIF_COLOR = 'green'
end
