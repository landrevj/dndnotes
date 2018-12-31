class Note < ApplicationRecord
    include Linkable
    belongs_to :user
end
