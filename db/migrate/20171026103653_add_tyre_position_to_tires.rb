class AddTyrePositionToTires < ActiveRecord::Migration[5.1]
  def change
    add_column :tires, :tyre_position, :string
  end
end
