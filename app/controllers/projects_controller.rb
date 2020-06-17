class ProjectsController < ApplicationController
  def index
    @projects = Project.all
  end
  
  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      redirect_to projects_url
    else
      render 'new'
    end
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
