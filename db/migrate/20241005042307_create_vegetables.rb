class CreateVegetables < ActiveRecord::Migration[6.1]
  def change
    create_table :vegetables do |t|
      t.integer :user_id, null: false
      t.string :name, null: false
      t.text :body, null: false
      t.integer :genre_id, null: false
      t.boolean :is_draft, default: true, null: false
      t.timestamps
    end
  end
end
