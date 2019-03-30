class SearchController < ApplicationController
    def search
        type = params[:type]
        @type_singular = type.singularize
        @motif_color = @type_singular.classify.constantize::MOTIF_COLOR
        @objects = current_user.send(type).ransack(name_cont: params[:q]).result(distinct: true).limit(10)
    end
end
