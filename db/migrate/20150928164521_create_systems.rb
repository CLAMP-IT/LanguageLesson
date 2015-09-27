class CreateSystems < ActiveRecord::Migration
  def change
    create_table :systems do |t|
      t.string :hostname
      t.references :institution, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
