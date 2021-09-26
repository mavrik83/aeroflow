# frozen_string_literal: true

class CreateQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :questions do |t|
      t.string :title
      t.text :content

      t.belongs_to :user
      t.belongs_to :category
      # t.belongs_to :tags

      t.timestamps
    end
  end
end
