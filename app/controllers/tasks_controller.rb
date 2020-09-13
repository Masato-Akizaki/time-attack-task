class TasksController < ApplicationController
  
  def index
    @tasks = Task.all.order("completed asc, date asc, created_at desc")
    @projects = Project.all
  end
  
  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to tasks_url
    else
      render 'new'
    end
  end
    
  def show
    @task = Task.find(params[:id])
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    if @task.update_attributes(task_params)
      redirect_to tasks_url
    else
      render "edit"
    end
  end

  def destroy
    @task = Task.find(params[:id])
    if @task.nil?
      redirect_to tasks_url
    elsif @task.destroy
      redirect_to tasks_url
    else
      redirect_to tasks_url
    end
  end

  def completed
    @tasks = Task.all.order("completed asc, date asc, created_at desc")
    @task = Task.find(params[:id])
    @project = @task.project_id ? Project.find(@task.project_id) : nil
    @task.completed = !@task.completed
    @task.save
  end

  def timer
    @task = Task.find(params[:id])
  end

  def today
    @today = Date.today
    @tasks = Task.where(date: @today).order("completed asc, date asc, created_at desc")
    @projects = Project.all
  end

  private

    def task_params
      params.require(:task).permit(:name, :date, :time, :memo, :completed, :project_id)
    end


end
