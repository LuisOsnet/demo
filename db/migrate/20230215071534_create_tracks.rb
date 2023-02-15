class CreateTracks < ActiveRecord::Migration[7.0]
  def change
    create_table :tracks, id: :uuid do |t|
      t.string :trackable_id, id: :uuid
      t.string :trackable_type
      t.string :user_id, id: :uuid
      t.string :user_name
      t.string :team_id, id: :uuid
      t.string :team_name
      t.datetime :started_at
      t.datetime :ended_at

      t.timestamps
    end
  end
end
