class CreateContexts < ActiveRecord::Migration
  def change
    create_table :contexts do |t|
      t.string :type
      t.references :lesson, index: true

      t.timestamps
    end
  end
end
