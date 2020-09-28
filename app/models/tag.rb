# frozen_string_literal: true

class Tag < ApplicationRecord
  has_and_belongs_to_many :answers
  has_and_belongs_to_many :questions
  validates :name, presence: true, length: [within: 3..15]
end
