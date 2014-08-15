class CreateInstitutions < ActiveRecord::Migration
  def up
    create_table :institutions do |t|
      t.string :name
      t.string :identifier
      t.boolean :active
      t.boolean :requested, default: false
      t.boolean :accepted, default: false

      t.timestamps
    end

    ['Reed College', 'Carleton College'].each { |iname| Institution.create(name: iname, identifier: SecureRandom.hex, active: true) } 
  end

  def down
    drop_table :institutions
  end
end
