class CommentsController < ApplicationController
  before_action :set_task, only: [:create, :update, :destroy]
  before_action :set_comment, only: [:update, :destroy]

  def create
    @comment = @task.comments.build(comment_params)
    if @comment.save
      redirect_to task_path(@task), notice: "Comment was successfully created."
    else
      redirect_to task_path(@task), alert: "Could not create comment"
    end
  end

  def update
    if @comment.update(comment_params)
      redirect_to task_path(@task), notice: "Comment was successfully updated."
    else
      redirect_to task_path(@task), alert: "Could not update comment"
    end
  end

  def destroy
    if @comment.destroy
      redirect_to task_path(@task), notice: "Comment was successfully destroyed."
    else
      redirect_to task_path(@task), alert: "Could not delete comment"
    end
  end

  private

  def set_task
    @task = Task.find(params[:task_id])
  end

  def set_comment
    @comment = @task.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
