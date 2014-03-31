class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.references :question
      t.string :title
      t.text :content
      t.string :type
      t.string :response
      t.integer :score

      t.timestamps
    end
    add_index :answers, :question_id
  end
end
