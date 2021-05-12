class CreateYesOrNoItems < ActiveRecord::Migration[6.0]
  def change
    create_table :yes_or_no_items do |t|
      t.string :content, null: false
      t.boolean :answer
      t.references :yes_or_no_block, null: false, foreign_key: true

      t.timestamps
    end
  end
end
