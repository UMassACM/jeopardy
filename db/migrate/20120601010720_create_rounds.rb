class CreateRounds < ActiveRecord::Migration
  def change
    create_table :rounds do |t|
      t.references :game

      t.timestamps
    end
    add_index :rounds, :game_id
  end
end
