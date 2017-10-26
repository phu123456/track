class AddPositionToTyres < ActiveRecord::Migration[5.1]
  def change
    add_column :tyres, :position, :string
  end
end
