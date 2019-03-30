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

    def related(type)
        self.send("outgoing_" + type) + self.send("incoming_" + type)
    end

    def get_relationship(other_id, other_type)
        self_id = self.id
        self_type = self.model_name.name
        link = Link.find_link([self_id, self_type], [other_id, other_type]).first
        if self_id == link.origin.id && self_type == link.origin.model_name.name
            'origin'
        elsif self_id == link.linkable.id && self_type == link.linkable.model_name.name
            'linkable'
        else
            'none'
        end
    end
end
