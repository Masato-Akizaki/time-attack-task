class ChangeDataProjectIdToTask < ActiveRecord::Migration[5.2]
  def change
    change_column :tasks, :project_id, :integer
  end
end
