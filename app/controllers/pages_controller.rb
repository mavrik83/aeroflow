# frozen_string_literal: true

class PagesController < ApplicationController
  def home
    redirect_to questions_path if logged_in?
  end
end
