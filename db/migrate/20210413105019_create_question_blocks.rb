class CreateQuestionBlocks < ActiveRecord::Migration[6.0]
  def change
    create_table :question_blocks do |t|
      t.string :title, null: false
      t.references :profile_block, null: false, foreign_key: true

      t.timestamps
    end
  end
end
