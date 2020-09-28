# frozen_string_literal: true

class CreateJoinTableTagQuestion < ActiveRecord::Migration[6.0]
  def change
    create_join_table :tags, :questions do |t|
      t.index %i[tag_id question_id]
      # t.index [:question_id, :tag_id]
    end
  end
end
