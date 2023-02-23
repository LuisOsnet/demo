# frozen_string_literal: true

class CreateTeams < ActiveRecord::Migration[7.0]
  def change
    create_table :teams, id: :uuid do |t|
      t.belongs_to :account, null: false, foreign_key: true, type: :uuid
      t.string :name
      t.timestamps
    end
  end
end
