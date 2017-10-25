class CreateServices < ActiveRecord::Migration[5.1]
  def change
    create_table :services do |t|
      t.string :name
      t.integer :distance_due

      t.timestamps
    end
  end
end
