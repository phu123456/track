class CreateVehicles < ActiveRecord::Migration[5.1]
  def change
    create_table :vehicles do |t|
      t.text :plate
      t.text :imei

      t.timestamps
    end
  end
end
