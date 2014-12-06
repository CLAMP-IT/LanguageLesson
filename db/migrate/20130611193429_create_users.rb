class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.integer :moodle_id
      t.references :institution
      
      t.timestamps
    end

    User.create(name: 'Daniel Landau', email: 'dlandau@reed.edu', institution_id: 1)
  end
end
