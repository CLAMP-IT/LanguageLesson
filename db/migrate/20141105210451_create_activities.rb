class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.string :name
      t.references :course, index: true
      t.integer :resource_link_id
      t.references :doable, polymorphic: true

      t.timestamps
    end
  end
end
