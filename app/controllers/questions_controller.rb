# frozen_string_literal: true

class QuestionsController < ApplicationController
  def show; end

  def index
    @questions = Question.all
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
