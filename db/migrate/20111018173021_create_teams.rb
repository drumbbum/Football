class CreateTeams < ActiveRecord::Migration
  def self.up
    create_table :teams do |t|
      t.string :city
      t.string :name
      t.string :full_name

      t.timestamps
    end
  end

  def self.down
    drop_table :teams
  end
end
