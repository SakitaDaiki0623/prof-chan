class CreateTextBlockLikes < ActiveRecord::Migration[6.0]
  def change
    create_table :text_block_likes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :text_block, null: false, foreign_key: true

      t.timestamps
    end
  end
end
