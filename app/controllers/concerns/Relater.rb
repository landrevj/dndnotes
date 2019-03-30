module Relater
    extend ActiveSupport::Concern

    def set_related(object)
        @related = {campaigns: object.related('campaigns'),
                  locations: object.related('locations'),
                  quests: object.related('quests'),
                  notes: object.related('notes'),
                  groups: object.related('groups'),
                  encounters: object.related('encounters')}
    end
end
