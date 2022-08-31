class CongratsController < ApplicationController
  def create
    @achieved_list_congrat = Congrat.new(
      user_id: current_user.id, achieved_list_id: params[:achieved_list_id]
    )
    @achieved_list_congrat.save
    redirect_to achieved_lists_path
  end

  def destroy
    @achieved_list_congrat = Congrat.find_by(
      user_id: current_user.id, achieved_list_id: params[:achieved_list_id]
    )
    @achieved_list_congrat.destroy
    redirect_to achieved_lists_path
  end

  def congrated?(user)
    congrats.where(user_id: user.id).exists?
  end
end
