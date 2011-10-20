class CreateMatchups < ActiveRecord::Migration
  def self.up
    create_table :matchups do |t|
      t.integer :home
      t.integer :away
      t.integer :week
      t.integer :winner
      t.date :time

      t.timestamps
    end
  end

  def self.down
    drop_table :matchups
  end
end
