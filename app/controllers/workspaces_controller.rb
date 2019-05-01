class WorkspacesController < ApplicationController
  before_action :set_workspace, only: [:edit, :update, :destroy]
  load_and_authorize_resource

  def active
    @workspace = current_user.workspaces.find_by(active: true)
    @category = current_user.categories.build
  end

  def edit
  end

  # POST /workspaces
  # POST /workspaces.json
  def create
    @workspace = current_user.workspaces.build(workspace_params)

    respond_to do |format|
      if @workspace.save
        format.html { redirect_to root_path, notice: 'Workspace was successfully created.' }
        format.json { render :index, status: :created, location: @workspace }
      else
        format.html { render :new }
        format.json { render json: @workspace.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /workspaces/1
  # PATCH/PUT /workspaces/1.json
  def update
    respond_to do |format|
      if @workspace.update(workspace_params)
        format.html { redirect_to root_path, notice: 'Workspace was successfully updated.' }
        format.json { render :show, status: :ok, location: @workspace }
      else
        format.html { render :edit }
        format.json { render json: @workspace.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /workspaces/1
  # DELETE /workspaces/1.json
  def destroy
    @workspace.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Workspace was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_workspace
    @workspace = Workspace.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def workspace_params
    params.require(:workspace).permit(:name, :active)
  end
end
