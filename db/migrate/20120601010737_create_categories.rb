class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.references :round

      t.timestamps
    end
    add_index :categories, :round_id
  end
end
