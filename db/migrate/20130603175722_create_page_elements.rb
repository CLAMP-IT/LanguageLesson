class CreatePageElements < ActiveRecord::Migration
  def change
    create_table :page_elements do |t|
      t.references :page
      t.integer :row_order
      t.references :pageable, :polymorphic => true

      t.timestamps
    end
    add_index :page_elements, :page_id
  end
end
