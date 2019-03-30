class AddNameAndDesctiptionToNotes < ActiveRecord::Migration[5.2]
  def change
    add_column :notes, :name, :string
    add_column :notes, :description, :text
  end
end
