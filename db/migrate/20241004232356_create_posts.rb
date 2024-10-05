class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.integer :user_id , null: false
      t.string :vege_name, null: false
      t.text :body, null: false
      t.integer :genere_id, null: false
      t.timestamps
    end
  end
end
