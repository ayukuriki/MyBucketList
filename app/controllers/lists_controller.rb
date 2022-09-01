class ListsController < ApplicationController
  before_action :set_categories,

  def index
    @lists = List.all.where(user_id: current_user.id)
    @users = User.all
  end

  def new
    @list = List.new
  end

  def create
    @list = List.new(list_params)
    @list.user_id = current_user.id
    if @list.save
      redirect_to mypage_path, notice: '新規リストが追加されました'
    else
      render "new"
    end
  end

  def edit
    @list = List.find(params[:id])
  end

  def update
    @list = List.find(params[:id])
    if @list.update(list_params)
      redirect_to mypage_path, notice: '新規リストが更新されました'
    else
      render :new
    end
  end

  def destroy
    @list = List.find(params[:id])
    @list.user_id = current_user.id
    @list.destroy!
    redirect_to mypage_path, notice: 'リストが削除されました'
  end

  def all_index
    @lists = List.all.where(public: true)
    @users = User.all
  end

  private

  def list_params
    params.require(:list).permit(:title, :description, :category_id, :target_year, :public)
  end

  def set_categories
    @categories = Category.all
  end
end
