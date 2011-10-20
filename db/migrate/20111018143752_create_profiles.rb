class CreateProfiles < ActiveRecord::Migration
  def self.up
    create_table :profiles do |t|
      t.string :first
      t.string :last
      t.boolean :paid
      t.integer :num_of_picks
      t.integer :favorite
      t.integer :user_id
      t.integer :league_id

      t.timestamps
    end
  end

  def self.down
    drop_table :profiles
  end
end
