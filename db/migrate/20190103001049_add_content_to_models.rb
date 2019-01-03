class AddContentToModels < ActiveRecord::Migration[5.2]
  def change
    add_column :locations, :content, :text
    add_column :quests, :content, :text
  end
end
