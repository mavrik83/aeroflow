# frozen_string_literal: true

class TagsController < ApplicationController
  def show; end

  def index
    @tags = tag.all
  end

  def new
    @tag = tag.new
  end

  def edit; end

  def update
    if @tag.update(tag_params)
      redirect_to @tag
    else
      redirect_to 'edit'
    end
  end

  def create
    @tag = tag.new(tag_params)
    @tag.user = current_user
    if @tag.save
      # flash[:success] = 'Save succesful!'
      redirect_to @tag
    else
      render 'new'
    end
  end

  def destroy
    @tag.destroy
    redirect_to tags_path
  end

  private

  def set_tag
    @tag = tag.find(params[:id])
  end

  def tag_params
    params.require(:tag).permit(:title, :content)
  end

  def require_same_user
    if current_user != @tag.user && !current_user.admin
      # flash[:danger] = "You can only edit or delete your own tags"
      redirect_to @tag
    end
  end
end
