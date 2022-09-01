class QuestionsController < ApplicationController
  before_action :set_categories

  def index
    @questions = Question.all
  end

  def show
    @question = Question.find(params[:id])
    @category = @categories.find(@question.category_id)
    @user = User.find(@question.user_id)
    @users = User.all
    @advices = @question.advices
    @advice = current_user.advices.new
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)
    @question.user_id = current_user.id
    if @question.save
      redirect_to questions_path, notice: '新規質問が追加されました'
    else
      render "new"
    end
  end

  private

  def question_params
    params.require(:question).permit(:title, :content, :category_id, :user_id)
  end

  def set_categories
    @categories = Category.all
  end
end
