class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.integer :genre_id
      t.string :name
      t.string :introduction
      t.integer :price
      t.string :image_id
      t.integer :sale_status

      t.timestamps
    end
  end
end
