class RenameStatusColumnToTasks < ActiveRecord::Migration[5.2]
  def change
    rename_column :tasks, :status, :completed
  end
end
