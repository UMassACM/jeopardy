class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :name
      t.text :final_prompt
      t.text :final_response

      t.timestamps
    end
  end
end
