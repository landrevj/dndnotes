class RemoveLinkIndicies < ActiveRecord::Migration[5.2]
  def change
    remove_index :links, :note_id
    remove_index :links, :linked_note_id
  end
end
