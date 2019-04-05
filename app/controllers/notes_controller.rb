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
    @linked_notes = @note.all_linked_notes.group_by { |n| n.category }.sort_by { |c, n| c.name }
    @link = current_user.links.build
    render :show, layout: 'page'
  end
  
  # GET /notes/new
  def new
    @note = current_user.notes.build
  end
  
  # GET /notes/1/edit
  def edit
    @linked_notes = @note.all_linked_notes.group_by { |n| n.category }.sort_by { |c, n| c.name }
  end

  # POST /notes
  # POST /notes.json
  def create
    @note = current_user.notes.build(note_params)

    respond_to do |format|
      if @note.save
        if params[:referrer_id]
          @note.links.build(linked_note_id: params[:referrer_id], user_id: current_user.id).save
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
      params.require(:note).permit(:name, :description, :content, :referrer_id, :category_id)
    end
end
