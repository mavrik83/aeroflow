# frozen_string_literal: true

class QuestionsController < ApplicationController
  before_action :set_question, only: %i[show edit update destroy]
  before_action :require_user, except: %i[show index]
  before_action :require_same_user, only: %i[edit update destroy]

  def show
    @answers = @question.answers.last(3)
  end

  def index
    if params[:sort] == "answered"
      @questions = Question.answered.paginate(page: params[:page], per_page: 5)
    elsif params[:sort] 
      @questions = Question.where('category_id = ?', params[:sort]).paginate(page: params[:page], per_page: 5)
    else
      @questions = Question.order('created_at DESC').paginate(page: params[:page], per_page: 5)
    end
  end

  def new
    @question = Question.new
  end

  def edit; end

  def update
    if @question.update(question_params)
      redirect_to @question
    else
      redirect_to 'edit'
    end
  end

  def create
    @question = question.new(question_params)
    @question.user = current_user
    if @question.save
      # flash[:success] = 'Save succesful!'
      redirect_to @question
    else
      render 'new'
    end
  end

  def destroy
    @question.destroy
    redirect_to questions_path
  end

  private

  def set_question
    @question = question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :content)
  end

  def require_same_user
    if current_user != @question.user && !current_user.admin
      # flash[:danger] = "You can only edit or delete your own questions"
      redirect_to @question
    end
  end
end
