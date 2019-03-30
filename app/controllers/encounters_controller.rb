class EncountersController < ApplicationController
  include Relater
  before_action :set_encounter, only: [:show, :edit, :update, :destroy]
  before_action -> { set_related(@encounter) }, only: [:show, :edit]
  load_and_authorize_resource

  # GET /encounters
  # GET /encounters.json
  def index
    @q = current_user.encounters.ransack(params[:q])
    @encounters = @q.result(distinct: true)
    render 'shared/notes/index', locals: { type_class: Encounter, objects: @encounters, new_path: new_encounter_path }
  end

  # GET /encounters/1
  # GET /encounters/1.json
  def show
    @link = current_user.links.build
    render 'shared/notes/show', layout: 'page', locals: { object: @encounter, edit_path: edit_encounter_path(@encounter) }
  end

  # GET /encounters/new
  def new
    @encounter = current_user.encounters.build
    render 'shared/notes/new', locals: { object: @encounter, url: encounters_path(referrer_id: params[:referrer_id], referrer_type: params[:referrer_type]) }
  end

  # GET /encounters/1/edit
  def edit
    render 'shared/notes/edit', locals: { object: @encounter }
  end

  # POST /encounters
  # POST /encounters.json
  def create
    @encounter = current_user.encounters.build(encounter_params)

    respond_to do |format|
      if @encounter.save
        if params[:referrer_id] && params[:referrer_type] 
          @encounter.incoming_links.build(origin_id: params[:referrer_id], origin_type: params[:referrer_type], user_id: current_user.id).save
        end
        format.html { redirect_to @encounter, notice: 'Encounter was successfully created.' }
        format.json { render :show, status: :created, location: @encounter }
      else
        format.html { render :new }
        format.json { render json: @encounter.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /encounters/1
  # PATCH/PUT /encounters/1.json
  def update
    respond_to do |format|
      if @encounter.update(encounter_params)
        format.html { redirect_to @encounter, notice: 'Encounter was successfully updated.' }
        format.json { render :show, status: :ok, location: @encounter }
      else
        format.html { render :edit }
        format.json { render json: @encounter.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /encounters/1
  # DELETE /encounters/1.json
  def destroy
    @encounter.destroy
    respond_to do |format|
      format.html { redirect_to encounters_url, notice: 'Encounter was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_encounter
      @encounter = Encounter.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def encounter_params
      params.require(:encounter).permit(:name, :description, :content, :referrer_id, :referrer_type)
    end
end
