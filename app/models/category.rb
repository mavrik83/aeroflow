# frozen_string_literal: true

class Category < ApplicationRecord
  has_many :questions
  has_many :users, through: :questions
end
