# frozen_string_literal: true

class AddTeamToUsers < ActiveRecord::Migration[7.0]
  def change
    add_reference :users, :team, null: true, foreign_key: true, type: :uuid
  end
end
