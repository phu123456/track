class CreateTyres < ActiveRecord::Migration[5.1]
  def change
    create_table :tyres do |t|
      t.string :brand
      t.text :serial
      t.decimal :start_distance
      t.decimal :total_distance
      t.string :status
      t.references :vehicle, foreign_key: true

      t.timestamps
    end
  end
end
