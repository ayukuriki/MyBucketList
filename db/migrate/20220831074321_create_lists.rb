class CreateLists < ActiveRecord::Migration[6.1]
  def change
    create_table :lists do |t|
      t.string :title
      t.text :description
      t.boolean :public
      t.integer :target_year
      t.integer :user_id
      t.integer :category_id

      t.timestamps
    end
  end
end
