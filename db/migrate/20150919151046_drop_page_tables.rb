class DropPageTables < ActiveRecord::Migration
  def up
    drop_table :page_elements
    drop_table :pages

    remove_column :lesson_elements, :pageable_id
  end
end
