module Linkable
    extend ActiveSupport::Concern

    included do
        has_many :outgoing_links, as: :origin, dependent: :destroy, class_name: "Link"
        has_many :incoming_links, as: :linkable, dependent: :destroy, class_name: "Link"
        
        has_many :outgoing_notes, through: :outgoing_links, source: :linkable, source_type: "Note"
        has_many :incoming_notes, through: :incoming_links, source: :origin, source_type: "Note"
    end

    def links
        outgoing_links.or(incoming_links)
    end

    def related
        outgoing_notes.merge(incoming_notes)
    end

    def get_relationship(other_id)
        self_id = self.id
        link = Link.find_link(self_id, other_id).first
        if self_id == link.origin.id
            'origin'
        elsif self_id == link.linkable.id
            'linkable'
        else
            'none'
        end
    end
end
