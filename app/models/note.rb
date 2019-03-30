class Note < ApplicationRecord
    include Linkable
    belongs_to :user
    belongs_to :category
end
