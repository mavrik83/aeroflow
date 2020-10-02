# frozen_string_literal: true

class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :user

  validates :title, presence: true, length: { minimum: 6, maximum: 1000 }
  validates :content, presence: true, length: { minimum: 20, maximum: 3500 }
end
