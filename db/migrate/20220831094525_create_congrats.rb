class CreateCongrats < ActiveRecord::Migration[6.1]
  def change
    create_table :congrats do |t|
      t.references :user, null: false, foreign_key: true
      t.references :achieved_list, null: false, foreign_key: true

      t.timestamps
    end
  end
end
