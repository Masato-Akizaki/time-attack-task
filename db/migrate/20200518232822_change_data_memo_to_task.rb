class ChangeDataMemoToTask < ActiveRecord::Migration[5.2]
  def change
      change_column :tasks, :memo, :text
  end
end
