class CreateRankingItems < ActiveRecord::Migration[6.0]
  def change
    create_table :ranking_items do |t|
      t.string :answer
      t.references :ranking_block, null: false, foreign_key: true

      t.timestamps
    end
  end
end
