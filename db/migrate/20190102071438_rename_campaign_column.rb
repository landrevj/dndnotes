class RenameCampaignColumn < ActiveRecord::Migration[5.2]
  def change
    rename_column :campaigns, :about, :description
  end
end
