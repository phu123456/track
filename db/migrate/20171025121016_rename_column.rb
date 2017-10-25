class RenameColumn < ActiveRecord::Migration[5.1]
  def change
    rename_column :service, :type, :name
  end
end
