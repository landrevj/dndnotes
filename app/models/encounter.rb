class Encounter < ApplicationRecord
  include Linkable
  belongs_to :user

  MOTIF_COLOR = 'red'
end
