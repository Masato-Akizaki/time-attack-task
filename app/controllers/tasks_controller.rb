class TasksController < ApplicationController
  before_action :logged_in_user
  before_action :set_task, only:[:show, :edit, :update, :destroy, :completed, :timer]
  before_action :set_tasks, only:[:completed, :all, :done, :no_project]
  before_action :set_projects, only:[:index, :all, :done, :no_project]
  after_action :save_return_url, only: [:new, :edit]
  
  def index
    if params[:date]
      @date = Date.parse(params[:date])
    else 
      @date = Date.today
    end
    @tasks = current_user.tasks.where(date: @date).order("completed asc, date asc, created_at desc")
  end
  
  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      redirect_to session.delete(:return_to)
    else
      flash[:alert] = @task.errors.full_messages
      redirect_to new_task_url
    end
  end
    
  def show
  end

  def edit
  end

  def update
    if @task.update_attributes(task_params)
      redirect_to session.delete(:return_to) 
    else
      flash[:alert] = @task.errors.full_messages
      redirect_to edit_task_url
    end
  end

  def destroy
    if @task.nil?
      redirect_to tasks_url
    elsif @task.destroy
      redirect_to tasks_url
    else
      redirect_to tasks_url
    end
  end

  def completed
    if @task.date
      @date = Date.parse("#{@task.date}")
    else 
      @date = Date.today
    end
    @project = @task.project_id ? Project.find(@task.project_id) : nil
    @task.completed = !@task.completed
    @task.save
  end

  def timer
  end

  def all
  end

  def done
  end

  def no_project
  end

  private

    def task_params
      params.require(:task).permit(:name, :date, :time, :memo, :completed, :project_id)
    end

    def set_task
      @task = current_user.tasks.find(params[:id])
    end

    def set_tasks
      @tasks = current_user.tasks.order("completed asc, date asc, created_at desc")
    end

    def set_projects
      @projects = current_user.projects.all
    end

end
