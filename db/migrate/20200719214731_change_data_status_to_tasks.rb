class ChangeDataStatusToTasks < ActiveRecord::Migration[5.2]
  def change
    change_column :tasks, :status, 'boolean USING CAST(status AS boolean)'
  end
end
