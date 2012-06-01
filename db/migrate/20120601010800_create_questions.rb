class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.text :prompt
      t.text :response
      t.references :category

      t.timestamps
    end
    add_index :questions, :category_id
  end
end
