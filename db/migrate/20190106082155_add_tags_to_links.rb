class AddTagsToLinks < ActiveRecord::Migration[5.2]
  def change
    add_column :links, :origin_tag, :string
    add_column :links, :linkable_tag, :string
  end
end
