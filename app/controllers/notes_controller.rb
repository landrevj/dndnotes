class NotesController < ApplicationController
  before_action :set_note, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource
  
  # GET /notes
  # GET /notes.json
  def index
  end
  
  # GET /notes/1
  # GET /notes/1.json
  def show
    @link = current_user.links.build

    # @linked_notes = @note.related.where('category_id IN (?)', current_user.categories.map(&:id))
    #                      .includes(:category)
    #                      .group_by { |n| n.category }
    render :show, layout: 'page'
  end
  
  # GET /notes/new
  def new
    @note = current_user.notes.build
  end
  
  # GET /notes/1/edit
  def edit
  end

  # POST /notes
  # POST /notes.json
  def create
    @note = current_user.notes.build(note_params)

    respond_to do |format|
      if @note.save
        if params[:referrer_id] && params[:referrer_type] 
          @note.incoming_links.build(origin_id: params[:referrer_id], origin_type: params[:referrer_type], user_id: current_user.id).save
        end
        format.html { redirect_to [@note.category, @note], notice: 'Note was successfully created.' }
        format.json { render :show, status: :created, location: @note }
      else
        format.html { render :new }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /notes/1
  # PATCH/PUT /notes/1.json
  def update
    respond_to do |format|
      if @note.update(note_params)
        format.html { redirect_to [@note.category, @note], notice: 'Note was successfully updated.' }
        format.json { render :show, status: :ok, location: [@note.category, @note] }
      else
        format.html { render :edit }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /notes/1
  # DELETE /notes/1.json
  def destroy
    category = @note.category
    @note.destroy
    respond_to do |format|
      format.html { redirect_to category, notice: 'Note was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_note
      @note = Note.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def note_params
      params.require(:note).permit(:name, :description, :content, :referrer_id, :referrer_type, :category_id)
    end
end
