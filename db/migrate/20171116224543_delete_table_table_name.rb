class DeleteTableTableName < ActiveRecord::Migration[5.1]
  def up
    drop_table :histories
  end
end
