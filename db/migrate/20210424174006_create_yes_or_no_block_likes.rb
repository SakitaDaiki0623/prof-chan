class CreateYesOrNoBlockLikes < ActiveRecord::Migration[6.0]
  def change
    create_table :yes_or_no_block_likes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :yes_or_no_block, null: false, foreign_key: true

      t.timestamps
    end
  end
end
