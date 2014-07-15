class CreateInstitutions < ActiveRecord::Migration
  def up
    create_table :institutions do |t|
      t.string :name
      t.string :identifier

      t.timestamps
    end

    ['Reed College', 'Carleton College'].each { |iname| Institution.create(name: iname, identifier: SecureRandom.hex) } 
  end

  def down
    drop_table :institutions
  end
end
