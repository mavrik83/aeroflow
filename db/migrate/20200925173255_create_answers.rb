# frozen_string_literal: true

class CreateAnswers < ActiveRecord::Migration[6.0]
  def change
    create_table :answers do |t|
      t.string :title
      t.string :content

      t.belongs_to :question
      t.belongs_to :user
      # t.belongs_to :tags

      t.timestamps
    end
  end
end
