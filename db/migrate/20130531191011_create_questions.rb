class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.text :title
      t.text :content
      t.integer :row_order
      t.string :type

      t.timestamps
    end
  end
end
