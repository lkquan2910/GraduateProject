class Admin::ProjectsController < GraduateProjectController
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  # GET /admin/projects
  # GET /admin/projects.json
  def index
    @admin_projects = Project.all
  end

  # GET /admin/projects/1
  # GET /admin/projects/1.json
  def show
  end

  # GET /admin/projects/new
  def new
    @admin_project = Project.new
  end

  # GET /admin/projects/1/edit
  def edit
  end

  # POST /admin/projects
  # POST /admin/projects.json
  def create
    @admin_project = Project.new(admin_project_params)

    respond_to do |format|
      if @admin_project.save
        format.html { redirect_to @admin_project, notice: 'Project was successfully created.' }
        format.json { render :show, status: :created, location: @admin_project }
      else
        format.html { render :new }
        format.json { render json: @admin_project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/projects/1
  # PATCH/PUT /admin/projects/1.json
  def update
    respond_to do |format|
      if @admin_project.update(admin_project_params)
        format.html { redirect_to @admin_project, notice: 'Project was successfully updated.' }
        format.json { render :show, status: :ok, location: @admin_project }
      else
        format.html { render :edit }
        format.json { render json: @admin_project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/projects/1
  # DELETE /admin/projects/1.json
  def destroy
    @admin_project.destroy
    respond_to do |format|
      format.html { redirect_to admin_projects_url, notice: 'Project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @admin_project = Project.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def project_params
      params.fetch(:admin_project, {})
    end
end