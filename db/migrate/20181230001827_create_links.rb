class CreateLinks < ActiveRecord::Migration[5.2]
  def change
    create_table :links do |t|
      t.references :origin, polymorphic: true
      t.references :linkable, polymorphic: true

      t.timestamps
    end
  end
end
