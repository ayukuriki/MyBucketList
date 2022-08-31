class CreateAchievedLists < ActiveRecord::Migration[6.1]
  def change
    create_table :achieved_lists do |t|
      t.string :title
      t.datetime :achieved_date
      t.integer :user_id
      t.text :report
      t.integer :category_id
      t.integer :list_id
      t.boolean :public

      t.timestamps
    end
  end
end
