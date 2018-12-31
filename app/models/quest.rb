class Quest < ApplicationRecord
    include Linkable
    belongs_to :user
end
