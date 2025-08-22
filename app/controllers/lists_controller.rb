class ListsController < ApplicationController
  before_action :set_list, only: [:update, :destroy]

  def index
    @lists = List.all
    @new_list = List.new
  end

  def create
    @list = List.new(list_params)
    if @list.save
      redirect_to root_path, notice: "List was successfully created."
    else
      redirect_to root_path, alert: "Could not create list"
    end
  end

  def update
    if @list.update(list_params)
      redirect_to root_path, notice: "List was successfully updated."
    else
      redirect_to root_path, alert: "Could not update list"
    end
  end

  def destroy
    if @list.destroy
      render json: { success: true }
    else
      render json: { success: false, errors: @list.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_list
    @list = List.find(params[:id])
  end

  def list_params
    params.require(:list).permit(:name)
  end

end
