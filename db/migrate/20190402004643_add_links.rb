class AddLinks < ActiveRecord::Migration[5.2]
  def change
    create_table :links do |t|
      t.timestamps
      t.belongs_to :note
      t.belongs_to :linked_note
      t.index [:note_id, :linked_note_id], unique: true
    end
  end
end
