class CreateTextBlocks < ActiveRecord::Migration[6.0]
  def change
    create_table :text_blocks do |t|
      t.string :title, null: false
      t.text :text, null: false
      t.references :profile_block, null: false, foreign_key: true

      t.timestamps
    end
  end
end
