class TasksController < ApplicationController
  before_action :set_list, only: [:create, :destroy]
  before_action :set_task, only: [:show, :update, :destroy]

  def show
  end

  def create
    @task = @list.tasks.build(task_params)
    if @task.save
      redirect_to root_path, notice: "Task was successfully created."
    else
      redirect_to root_path, alert: "Could not create task"
    end
  end

  def update
    if @task.update(task_params)
      if params[:task][:status] == "closed"
        redirect_to root_path, notice: "Task marked as done!"
      else
        redirect_to task_path(@task), notice: "Task was successfully updated."
      end
    else
      redirect_to task_path(@task), alert: "Could not update task"
    end
  end

  def destroy
    if @task.destroy
      redirect_to root_path, notice: "Task was successfully destroyed."
    else
      redirect_to root_path, alert: "Could not delete task"
    end
  end

  private

  def set_list
    @list = List.find(params[:list_id])
  end

  def set_task
    if params[:list_id]
      @list ||= List.find(params[:list_id])
      @task = @list.tasks.find(params[:id])
    else
      @task = Task.find(params[:id])
    end
  end

  def task_params
    params.require(:task).permit(:name, :description, :status)
  end
end
