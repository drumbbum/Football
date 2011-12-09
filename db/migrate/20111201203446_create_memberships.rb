class CreateMemberships < ActiveRecord::Migration
  def self.up
    create_table :memberships do |t|
      t.integer :league_id
      t.integer :profile_id
      t.integer :num_of_picks
      t.boolean :paid
      t.boolean :admin

      t.timestamps
    end
  end

  def self.down
    drop_table :memberships
  end
end
