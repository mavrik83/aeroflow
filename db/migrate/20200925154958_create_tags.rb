# frozen_string_literal: true

class CreateTags < ActiveRecord::Migration[6.0]
  def change
    create_table :tags do |t|
      t.string :name

      # t.belongs_to :answer
      # t.belongs_to :question

      t.timestamps
    end
  end
end
