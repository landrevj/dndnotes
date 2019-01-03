class QuestsController < ApplicationController
  before_action :set_quest, only: [:show, :edit, :update, :destroy]
  before_action :set_related, only: [:show, :edit]
  load_and_authorize_resource

  # GET /quests
  # GET /quests.json
  def index
    @quests = current_user.quests
  end

  # GET /quests/1
  # GET /quests/1.json
  def show
    @campaigns = @quest.related('campaigns')
    @locations = @quest.related('locations')
    @quests = @quest.related('quests')
    @notes = @quest.related('notes')
    render :show, layout: 'page'
  end

  # GET /quests/new
  def new
    @quest = current_user.quests.build
  end

  # GET /quests/1/edit
  def edit
  end

  # POST /quests
  # POST /quests.json
  def create
    @quest = current_user.quests.build(quest_params)

    respond_to do |format|
      if @quest.save
        format.html { redirect_to @quest, notice: 'Quest was successfully created.' }
        format.json { render :show, status: :created, location: @quest }
      else
        format.html { render :new }
        format.json { render json: @quest.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /quests/1
  # PATCH/PUT /quests/1.json
  def update
    respond_to do |format|
      if @quest.update(quest_params)
        format.html { redirect_to @quest, notice: 'Quest was successfully updated.' }
        format.json { render :show, status: :ok, location: @quest }
      else
        format.html { render :edit }
        format.json { render json: @quest.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /quests/1
  # DELETE /quests/1.json
  def destroy
    @quest.destroy
    respond_to do |format|
      format.html { redirect_to quests_url, notice: 'Quest was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_quest
      @quest = Quest.find(params[:id])
    end

    def set_related
      @campaigns = @quest.related('campaigns')
      @locations = @quest.related('locations')
      @quests = @quest.related('quests')
      @notes = @quest.related('notes')
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def quest_params
      params.require(:quest).permit(:name, :description)
    end
end
