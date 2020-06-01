class TasksController < ApplicationController
  
  def index
    @tasks = Task.all.order("status asc, date asc, created_at desc")
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
      redirect_to task_url(id: params[:id])
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

  private

    def task_params
      params.require(:task).permit(:name, :date, :time, :memo, :status)
    end


end
