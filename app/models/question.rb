# frozen_string_literal: true

class Question < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :answers, dependent: :destroy

  validates :title, presence: true, length: { minimum: 6, maximum: 1000 }
  validates :content, presence: true, length: { minimum: 20, maximum: 3500 }

  scope :answered, -> { where(answered: true) }
end
