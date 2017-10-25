class CreateMaintenances < ActiveRecord::Migration[5.1]
  def change
    create_table :maintenances do |t|
      t.integer :service_id
      t.integer :start_distance
      t.integer :current_distance
      t.integer :manually_distance
      t.references :vehicle, foreign_key: true

      t.timestamps
    end
  end
end
