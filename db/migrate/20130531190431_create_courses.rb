class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.integer :context_id
      t.string :context_label
      t.string :context_title
      t.string :name
      t.references :institution
      
      t.timestamps
    end
  end
end
