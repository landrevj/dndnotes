class SearchController < ApplicationController
    def search
        @category = Category.find(params[:category_id])
        @notes = @category.notes.ransack(name_cont: params[:q]).result(distinct: true).limit(10)
    end
end
