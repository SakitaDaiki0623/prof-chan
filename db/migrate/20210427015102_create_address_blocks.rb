class CreateAddressBlocks < ActiveRecord::Migration[6.0]
  def change
    create_table :address_blocks do |t|
      t.string :twitter
      t.string :instagram
      t.string :postcode
      t.string :prefecture_name
      t.string :address_city
      t.string :address_street
      t.string :address_building

      t.references :profile_block, null: false, foreign_key: true

      t.timestamps
    end
  end
end
