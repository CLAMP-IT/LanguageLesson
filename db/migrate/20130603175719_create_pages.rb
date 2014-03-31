class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.references :lesson
      t.string :title
      t.integer :row_order

      t.timestamps
    end
    add_index :pages, :lesson_id
  end
end
