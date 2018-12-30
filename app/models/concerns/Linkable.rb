module Linkable
    extend ActiveSupport::Concern

    included do
        has_many :outgoing_links, as: :origin, dependent: :destroy, class_name: "Link"
        has_many :incoming_links, as: :linkable, dependent: :destroy, class_name: "Link"

        has_many :outgoing_notes, through: :outgoing_links, source: :linkable, source_type: "Note"
        has_many :incoming_notes, through: :incoming_links, source: :origin, source_type: "Note"
    end
end
