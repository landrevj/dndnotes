class CampaignsController < ApplicationController
  include Relater
  before_action :set_campaign, only: [:show, :edit, :update, :destroy]
  before_action -> { set_related(@campaign) }, only: [:show, :edit]
  load_and_authorize_resource

  # GET /campaigns
  # GET /campaigns.json
  def index
    @q = current_user.campaigns.ransack(params[:q])
    @campaigns = @q.result(distinct: true)
    render 'shared/notes/index', locals: { type_class: Campaign, objects: @campaigns, new_path: new_campaign_path }
  end

  # GET /campaigns/1
  # GET /campaigns/1.json
  def show
    @link = current_user.links.build
    render 'shared/notes/show', layout: 'page', locals: { object: @campaign, edit_path: edit_campaign_path(@campaign) }
  end

  # GET /campaigns/new
  def new
    @campaign = current_user.campaigns.build
    render 'shared/notes/new', locals: { object: @campaign, url: campaigns_path(referrer_id: params[:referrer_id], referrer_type: params[:referrer_type]) }
  end

  # GET /campaigns/1/edit
  def edit
    render 'shared/notes/edit', locals: { object: @campaign }
  end

  # POST /campaigns
  # POST /campaigns.json
  def create
    @campaign = current_user.campaigns.build(campaign_params)

    respond_to do |format|
      if @campaign.save
        if params[:referrer_id] && params[:referrer_type] 
          @campaign.incoming_links.build(origin_id: params[:referrer_id], origin_type: params[:referrer_type], user_id: current_user.id).save
        end
        format.html { redirect_to @campaign, notice: 'Campaign was successfully created.' }
        format.json { render :show, status: :created, location: @campaign }
      else
        format.html { render :new }
        format.json { render json: @campaign.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /campaigns/1
  # PATCH/PUT /campaigns/1.json
  def update
    respond_to do |format|
      if @campaign.update(campaign_params)
        format.html { redirect_to @campaign, notice: 'Campaign was successfully updated.' }
        format.json { render :show, status: :ok, location: @campaign }
      else
        format.html { render :edit }
        format.json { render json: @campaign.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /campaigns/1
  # DELETE /campaigns/1.json
  def destroy
    @campaign.destroy
    respond_to do |format|
      format.html { redirect_to campaigns_url, notice: 'Campaign was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_campaign
      @campaign = Campaign.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def campaign_params
      params.require(:campaign).permit(:name, :description, :content, :referrer_id, :referrer_type)
    end
end
