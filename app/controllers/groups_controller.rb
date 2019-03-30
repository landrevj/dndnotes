class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :edit, :update, :destroy]
  before_action :set_related, only: [:show, :edit]
  load_and_authorize_resource

  # GET /groups
  # GET /groups.json
  def index
    @q = current_user.groups.ransack(params[:q])
    @groups = @q.result(distinct: true)
    render 'shared/notes/index', locals: { type_class: Group, objects: @groups, new_path: new_group_path }
  end

  # GET /groups/1
  # GET /groups/1.json
  def show
    @link = current_user.links.build
    render 'shared/notes/show', layout: 'page', locals: { object: @group, edit_path: edit_group_path(@group) }
  end

  # GET /groups/new
  def new
    @group = current_user.groups.build
    render 'shared/notes/new', locals: { object: @group, url: groups_path(referrer_id: params[:referrer_id], referrer_type: params[:referrer_type]) }
  end

  # GET /groups/1/edit
  def edit
    render 'shared/notes/edit', locals: { object: @group }
  end

  # POST /groups
  # POST /groups.json
  def create
    @group = current_user.groups.build(group_params)

    respond_to do |format|
      if @group.save
        if params[:referrer_id] && params[:referrer_type] 
          @group.incoming_links.build(origin_id: params[:referrer_id], origin_type: params[:referrer_type], user_id: current_user.id).save
        end
        format.html { redirect_to @group, notice: 'Group was successfully created.' }
        format.json { render :show, status: :created, location: @group }
      else
        format.html { render :new }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /groups/1
  # PATCH/PUT /groups/1.json
  def update
    respond_to do |format|
      if @group.update(group_params)
        format.html { redirect_to @group, notice: 'Group was successfully updated.' }
        format.json { render :show, status: :ok, location: @group }
      else
        format.html { render :edit }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/1
  # DELETE /groups/1.json
  def destroy
    @group.destroy
    respond_to do |format|
      format.html { redirect_to groups_url, notice: 'Group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group
      @group = Group.find(params[:id])
    end

    def set_related
      @campaigns = @group.related('campaigns')
      @locations = @group.related('locations')
      @quests = @group.related('quests')
      @notes = @group.related('notes')
      @groups = @group.related('groups')
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def group_params
      params.require(:group).permit(:name, :description, :content, :referrer_id, :referrer_type)
    end
end
