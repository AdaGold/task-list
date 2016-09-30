class TasksController < ApplicationController

  def index
    @tasks = Task.all
  end

  def show
    @task = Task.find(params[:id])
  end

  def new
    @completion_status_options = ["New", "Pending", "Completed"]
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to tasks_path
    else
      render :new
    end
  end

  def edit
    @completion_status_options = ["New", "Pending", "Completed"]
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
      if @task.update(task_params)
        redirect_to tasks_path
      else
        render :edit
      end
  end

  def complete
    @task = Task.find(params[:id])
    @task[:completion_status] = "Completed"
    @task[:completion_date] = Date.today
    @task.save
    redirect_to tasks_path
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to tasks_path
  end

end

private
  def task_params
    params.require(:task).permit(:name, :description, :completion_status, :completion_date)
  end
