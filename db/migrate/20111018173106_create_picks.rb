class CreatePicks < ActiveRecord::Migration
  def self.up
    create_table :picks do |t|
      t.integer :profile_id
      t.integer :league_id
      t.integer :team_id
      t.integer :week

      t.timestamps
    end
  end

  def self.down
    drop_table :picks
  end
end
