class AddBloodTypesToProfiles < ActiveRecord::Migration[6.0]
  def change
    add_column :profiles, :blood_type, :integer, null: false
    add_column :profiles, :prefecture_id, :integer, null: false
  end
end
