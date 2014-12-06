class CreateLessons < ActiveRecord::Migration
  def change
    create_table :lessons do |t|
      t.string :name
      t.boolean :graded, default: false 
      t.boolean :auto_grading, default: false 
      t.boolean :hide_previous_answer, default: false 
      t.boolean :reattempt_allowed, default: false 
      t.integer :reattempt_limit, default: 3
      t.string  :default_correct
      t.string  :default_incorrect
      t.integer :max_score
      t.string  :language_context
      
      t.timestamps
    end
  end
end
