# frozen_string_literal: true

class CreateJoinTableTagAnswer < ActiveRecord::Migration[6.0]
  def change
    create_join_table :tags, :answers do |t|
      t.index %i[tag_id answer_id]
      # t.index [:answer_id, :tag_id]
    end
  end
end
