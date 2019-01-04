class SearchController < ApplicationController
    def search
        type = params[:type]
        if type == 'notes'
            @name = false 
            @objects = current_user.send(type).ransack(content_cont: params[:q]).result(distinct: true).limit(10)
        else
            @name = true
            @objects = current_user.send(type).ransack(name_cont: params[:q]).result(distinct: true).limit(10)
        end
            
    end
end
