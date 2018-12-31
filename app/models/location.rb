class Location < ApplicationRecord
    include Linkable
    belongs_to :user
end
