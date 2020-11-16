class ProjectsController < ApplicationController
  def index
    @projects = current_user.projects.all
  end
  
  def new
    @project = Project.new
  end

  def create
    @project = current_user.projects.build(project_params)
    if @project.save
      redirect_to projects_url
    else
      render 'new'
    end
  end

  def show
    @project = Project.find(params[:id])
    @projects = current_user.projects.all
    @tasks = current_user.tasks.where(project_id: @project.id).order("completed asc, date asc, created_at desc")
  end

  def edit
    @project = Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])
    if @project.update_attributes(project_params)
      redirect_to projects_url
    else
      render "edit"
    end
  end

  def destroy
    @project = Project.find(params[:id])
    if @project.nil?
      redirect_to projects_url
    elsif @project.destroy
      redirect_to projects_url
    else
      redirect_to projects_url
    end
  end

  private

    def project_params
      params.require(:project).permit(:name)
    end

end
