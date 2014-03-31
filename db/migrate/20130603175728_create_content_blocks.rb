class CreateContentBlocks < ActiveRecord::Migration
  def change
    create_table :content_blocks do |t|
      t.integer :row_order
      t.text :title
      t.text :content

      t.timestamps
    end
  end
end
