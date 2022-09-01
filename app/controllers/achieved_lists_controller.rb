class AchievedListsController < ApplicationController
  before_action :set_categories

  def index
    @achieved_lists = AchievedList.all.where(public: true).order(created_at: :desc)
    @users = User.all
  end

  def new
    @achieved_list = AchievedList.new
    @list = List.find_by(id: params[:id])
  end

  def create
    @achieved_list = AchievedList.new(achieved_list_params)
    @achieved_list.user_id = current_user.id
    @list = List.find(@achieved_list.list_id)
    if @achieved_list.save
      redirect_to achieved_lists_path, notice: '達成済リストが更新されました'
      @list.destroy
    else
      render "new"
    end
  end

  def my_index
    @achieved_lists = AchievedList.all.where(user_id: current_user.id).order(created_at: :desc)
  end

  def destroy
    @achieved_list = AchievedList.find(params[:id])
    @achieved_list.user_id = current_user.id
    @achieved_list.destroy
    redirect_to my_achieved_lists_path, notice: 'リストが削除されました'
  end

  private

  def achieved_list_params
    params.require(:achieved_list).permit(
      :title, :report, :category_id, :user_id, :achieved_date, :public, :image, :list_id
    )
  end

  def set_categories
    @categories = Category.all
  end
end
