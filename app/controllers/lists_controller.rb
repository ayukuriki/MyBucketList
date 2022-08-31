class ListsController < ApplicationController

  def index

  end

  def new

  end

  def create

  end

  def edit

  end

  def update

  end

  def destroy

  end

  def all_index

  end

  private

  def list_params
    params.require(:list).permit(:title, :description, :category_id, :target_year, :public)
  end

end
