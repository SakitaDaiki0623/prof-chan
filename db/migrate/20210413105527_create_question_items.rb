class CreateQuestionItems < ActiveRecord::Migration[6.0]
  def change
    create_table :question_items do |t|
      t.string :content, null: false
      t.string :answer
      t.references :question_block, null: false, foreign_key: true

      t.timestamps
    end
  end
end
