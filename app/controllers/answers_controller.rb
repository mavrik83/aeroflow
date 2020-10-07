# frozen_string_literal: true

class AnswersController < ApplicationController
  before_action :set_answer, only: %i[show edit update destroy]
  before_action :set_question, only: %i[new create]
  before_action :require_user, excpet: %i[show index]

  def index
    if params[:question_id]
      set_question
      @title = "All Answers for: #{@question.title}"
      @answers = @question.answers.order('created_at DESC').paginate(page: params[:page], per_page: 5)
    else
      @title = 'All Answers'
      @answers = Answer.order('created_at DESC').paginate(page: params[:page], per_page: 5)
    end
  end

  def new
    @answer = Answer.new
  end

  def edit; end

  def update
    if @answer.update(answer_params)
      redirect_to question_path(@answer.question)
    else
      render 'edit'
    end
  end

  def create
    @answer = Answer.new(answer_params)
    @answer.question_id = params[:question_id]
    @answer.user = current_user
    @question.answered = true
    if @answer.save
      @question.save
      flash[:success] = 'Save succesful!'
      redirect_to question_path(@answer.question)
    else
      render 'new'
    end
  end

  def destroy
    answer = @answer
    @answer.destroy
    if answer.question.answers.count.zero?
      answer.question.answered = false
      answer.question.save
    end
    redirect_to question_path(answer.question_id)
  end

  private

  def set_question
    @question = Question.find(params[:question_id])
  end

  def set_answer
    @answer = Answer.find(params[:id])
  end

  def answer_params
    params.require(:answer).permit(:title, :content, :question_id)
  end
end
