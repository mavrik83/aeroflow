# frozen_string_literal: true

class TagsController < ApplicationController
  has_many :answers
  has_many :questions, through: :answers
end
