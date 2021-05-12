class CreateRankingBlocks < ActiveRecord::Migration[6.0]
  def change
    create_table :ranking_blocks do |t|
      t.string :title, null: false
      t.string :first_place, null: false
      t.string :second_place, null: false
      t.string :third_place, null: false
      t.references :profile_block, null: false, foreign_key: true

      t.timestamps
    end
  end
end
