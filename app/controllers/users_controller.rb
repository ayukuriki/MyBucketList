class UsersController < ApplicationController
  def show
    @user = current_user
    @users = User.all
    @lists = List.all.where(user_id: current_user.id)
    @achieved_lists = AchievedList.all.where(user_id: current_user.id)
  end
end
