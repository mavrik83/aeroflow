# frozen_string_literal: true

class CategoriesController < ApplicationController
  def show; end

  def index
    @categories = category.all
  end

  def new
    @category = category.new
  end

  def edit; end

  def update
    if @category.update(category_params)
      redirect_to @category
    else
      redirect_to 'edit'
    end
  end

  def create
    @category = category.new(category_params)
    @category.user = current_user
    if @category.save
      # flash[:success] = 'Save succesful!'
      redirect_to @category
    else
      render 'new'
    end
  end

  def destroy
    @category.destroy
    redirect_to categories_path
  end

  private

  def set_category
    @category = category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:title, :content)
  end

  def require_same_user
    if current_user != @category.user && !current_user.admin
      # flash[:danger] = "You can only edit or delete your own categories"
      redirect_to @category
    end
  end
end
