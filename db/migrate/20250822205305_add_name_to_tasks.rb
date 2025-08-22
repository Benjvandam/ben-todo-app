class AddNameToTasks < ActiveRecord::Migration[8.0]
  def change
    add_column :tasks, :name, :string
  end
end
