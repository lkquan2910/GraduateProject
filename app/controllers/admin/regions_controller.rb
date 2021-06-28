class Admin::RegionsController < GraduateProjectController
  before_action :set_customer, only: [:show, :edit, :update, :destroy]

  def index
    @regions = Region.all
  end

  def get_regions
    @districts = RegionData.where(parent_id: params[:parent_id])
    respond_to do |format|
      format.json { render json: @districts }
    end
  end
end
