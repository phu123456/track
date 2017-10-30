class ChangeIntegerToDecimal < ActiveRecord::Migration[5.1]
  def change
    change_column :maintenances, :current_distance, :decimal
  end
end
