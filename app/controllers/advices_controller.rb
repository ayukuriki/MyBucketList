class AdvicesController < ApplicationController
  def create
    @advice = current_user.advices.new(advice_params)
    if @advice.save
      flash[:success] = "アドバイスを投稿しました"
      redirect_to question_path(@advice.question_id)
    else
      redirect_to question_path(@advice.question_id)
    end
  end

  def destroy
    @advice = Advice.find(params[:id])
    if current_user.id == @advice.user.id
      @advice.destroy!
      redirect_to question_path(@advice.question_id)
    else
      render question_path(@advice.question_id)
    end
  end

  private

  def advice_params
    params.require(:advice).permit(:content, :question_id, :user_id)
  end
end
