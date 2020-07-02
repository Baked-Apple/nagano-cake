class CreateGenres < ActiveRecord::Migration[5.2]
  def change
    create_table :genres do |t|
      t.string :genre
      t.integer :invalid_status

      t.timestamps
    end
  end
end
