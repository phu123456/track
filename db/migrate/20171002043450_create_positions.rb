class CreatePositions < ActiveRecord::Migration[5.1]
  def change
    create_table :positions do |t|
      t.float :latitude
      t.float :longitude
      t.integer :speed
      t.text :imei
      t.date :period

      t.timestamps
    end
  end
end
