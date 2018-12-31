class AddUserToQuests < ActiveRecord::Migration[5.2]
  def change
    add_reference :quests, :user, foreign_key: true
  end
end
