class Campaign < ApplicationRecord
    include Linkable
    belongs_to :user
end
