class AddActiveToWorkspaces < ActiveRecord::Migration[5.2]
  def change
    add_column :workspaces, :active, :boolean
  end
end
