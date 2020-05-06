class TasksController < ApplicationController
  
  def index
    @tasks = Task.all
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
    @task = Task.find_by(id: params[:id])
  end

  def update
    @task = Task.find(params[:id])
    if @task.update_attributes(task_params)
      redirect_to task_url(id: params[:id])
    else
      render "edit"
    end
  end

  private

    def task_params
      params.require(:task).permit(:name, :detail)
    end


end
