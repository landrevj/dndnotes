class CreateEncounters < ActiveRecord::Migration[5.2]
  def change
    create_table :encounters do |t|
      t.string :name
      t.text :description
      t.text :content
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
