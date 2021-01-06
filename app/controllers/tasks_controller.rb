class TasksController < ApplicationController
  before_action :logged_in_user
  
  def index
    if params[:date]
      @date = Date.parse(params[:date])
    else 
      @date = Date.today
    end
    @tasks = current_user.tasks.where(date: @date).order("completed asc, date asc, created_at desc")
    @projects = current_user.projects.all
  end
  
  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      redirect_to tasks_url
    else
      flash[:danger] = @task.errors.full_messages
      redirect_to new_task_url
    end
  end
    
  def show
    @task = current_user.tasks.find(params[:id])
  end

  def edit
    @task = current_user.tasks.find(params[:id])
  end

  def update
    @task = current_user.tasks.find(params[:id])
    if @task.update_attributes(task_params)
      redirect_to tasks_url
    else
      flash[:danger] = @task.errors.full_messages
      redirect_to edit_task_url
    end
  end

  def destroy
    @task = current_user.tasks.find(params[:id])
    if @task.nil?
      redirect_to tasks_url
    elsif @task.destroy
      redirect_to tasks_url
    else
      redirect_to tasks_url
    end
  end

  def completed
    @tasks = current_user.tasks.order("completed asc, date asc, created_at desc")
    @task = current_user.tasks.find(params[:id])
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
    @task = current_user.tasks.find(params[:id])
  end

  def all
    @tasks = current_user.tasks.order("completed asc, date asc, created_at desc")
    @projects = Project.all
  end

  private

    def task_params
      params.require(:task).permit(:name, :date, :time, :memo, :completed, :project_id)
    end


end
