class CreateLeagues < ActiveRecord::Migration
  def self.up
    create_table :leagues do |t|
      t.string :name
      t.boolean :repick
      t.boolean :show_paid
      t.boolean :show_history

      t.timestamps
    end
  end

  def self.down
    drop_table :leagues
  end
end
