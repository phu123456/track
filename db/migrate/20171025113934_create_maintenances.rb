class CreateMaintenances < ActiveRecord::Migration[5.1]
  def change
    create_table :maintenances do |t|
      t.integer :service_id
      t.decimal :start_distance
      t.decimal :current_distance
      t.decimal :manually_distance
      t.references :vehicle, foreign_key: true
      t.timestamps
    end
  end
end
