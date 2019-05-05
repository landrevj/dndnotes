class SearchController < ApplicationController
  def search
    respond_to do |format|
      format.html {
        @q = current_user.active_workspace.notes.ransack(params[:q])
        @notes = @q.result(distinct: true)
      }
      format.json {
        if params.key?(:category_id)
          @category = Category.find(params[:category_id])
          @notes = @category.notes.ransack(name_cont: params[:q]).result(distinct: true).limit(10)
        else
          @notes = current_user.active_workspace.notes.ransack(name_cont: params[:q]).result(distinct: true).limit(10)
        end
      }
    end
  end
end
