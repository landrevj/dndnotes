class Category < ApplicationRecord
    belongs_to :user
    has_many :notes, dependent: :destroy

    validates :name, presence: true

    COLORS = [
        ['Red', 'red'],
        ['Pink', 'pink'],
        ['Orange', 'orange'],
        ['Yellow', 'yellow'],
        ['Green', 'green'],
        ['Teal', 'teal'],
        ['Blue', 'blue'],
        ['Cyan', 'cyan'],
        ['Purple', 'purple'],
        ['Indigo', 'indigo'],
        ['Gray', 'gray'],
        ];
end
