class ProjectsController < ApplicationController
  after_action :save_return_url, only: [:new, :edit]

  def index
    @projects = current_user.projects.all
  end
  
  def new
    @project = Project.new(session[:project] || {})
  end

  def create
    @project = current_user.projects.build(project_params)
    if @project.save
      redirect_to session.delete(:return_to)
    else
      session[:project] = @project.attributes.slice(*project_params.keys)
      flash[:alert] = @project.errors.full_messages
      redirect_to new_project_url
    end
  end

  def show
    @project = current_user.projects.find(params[:id])
    @projects = current_user.projects.all
    @tasks = current_user.tasks.where(project_id: @project.id).order("completed asc, date asc, created_at desc")
  end

  def edit
    @project = current_user.projects.find(params[:id])
  end

  def update
    @project = current_user.projects.find(params[:id])
    if @project.update_attributes(project_params)
      redirect_to session.delete(:return_to)
    else
      flash[:alert] = @project.errors.full_messages
      redirect_to edit_project_url
    end
  end

  def destroy
    @project = current_user.projects.find(params[:id])
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
