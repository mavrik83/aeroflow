# frozen_string_literal: true

class AnswersController < ApplicationController
  def show; end

  def index
    @answers = answer.all
  end

  def new
    @answer = answer.new
  end

  def edit; end

  def update
    if @answer.update(answer_params)
      redirect_to @answer
    else
      redirect_to 'edit'
    end
  end

  def create
    @answer = answer.new(answer_params)
    @answer.user = current_user
    if @answer.save
      # flash[:success] = 'Save succesful!'
      redirect_to @answer
    else
      render 'new'
    end
  end

  def destroy
    @answer.destroy
    redirect_to answers_path
  end

  private

  def set_answer
    @answer = answer.find(params[:id])
  end

  def answer_params
    params.require(:answer).permit(:title, :content)
  end

  def require_same_user
    if current_user != @answer.user && !current_user.admin
      # flash[:danger] = "You can only edit or delete your own answers"
      redirect_to @answer
    end
  end
end
