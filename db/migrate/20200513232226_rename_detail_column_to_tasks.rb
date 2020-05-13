class RenameDetailColumnToTasks < ActiveRecord::Migration[5.2]
  def change
    rename_column :tasks, :detail, :memo
  end
end
