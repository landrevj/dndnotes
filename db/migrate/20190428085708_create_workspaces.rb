class CreateWorkspaces < ActiveRecord::Migration[5.2]
  def change
    create_table :workspaces do |t|
      t.string :name
      t.references :user, foreign_key: true

      t.timestamps
    end

    add_reference :categories, :workspace, foreign_key: true
  end
end
