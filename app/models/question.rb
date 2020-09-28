# frozen_string_literal: true

class Question < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :answers
  has_and_belongs_to_many :tags

  validates :title, presence: true, length: { minimum: 6, maximum: 100 }
  validates :content, presence: true, length: { minimum: 10, maximum: 600 }
end

# Question.where(‘title like ?’, ‘%engine%’)
