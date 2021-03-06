class LinksController < ApplicationController
  before_action :set_link, only: [:show, :edit, :update, :destroy]  
  load_and_authorize_resource

  # GET /links/1/edit
  def edit
  end

  # POST /links
  # POST /links.json
  def create
    @link = current_user.links.build(link_params)

    respond_to do |format|
      if @link.save
        format.html { redirect_to [@link.note.category.workspace, @link.note.category, @link.note], notice: 'Link was successfully created.' }
        format.json { render :show, status: :created, location: @link }
      else
        flash[:alert] = "Could not create link."
        format.html { redirect_back fallback_location: root_path }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /links/1
  # PATCH/PUT /links/1.json
  def update
    respond_to do |format|
      if @link.update(link_params)
        format.html { redirect_to [@link.note.category.workspace, @link.note.category, @link.note], notice: 'Link was successfully updated.' }
        format.json { render :show, status: :ok, location: [@link.note.category.workspace, @link.note.category, @link.note] }
      else
        format.html { render :edit }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /links/1
  # DELETE /links/1.json
  def destroy
    note = @link.note
    @link.destroy
    respond_to do |format|
      format.html { redirect_to [note.category.workspace, note.category, note], notice: 'Link was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_link
    @link = Link.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def link_params
    params.require(:link).permit(:note_id, :linked_note_id)
  end
end
