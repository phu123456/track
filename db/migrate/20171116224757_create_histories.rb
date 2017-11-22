class CreateHistories < ActiveRecord::Migration[5.1]
  def change
    create_table :histories do |t|
      t.string :category
      t.integer :vehicle
      t.string :before_value
      t.string :after_value
      t.string :email
      t.string :attribute_name

      t.timestamps
    end
  end
end
