class CreateInstitutions < ActiveRecord::Migration
  def up
    create_table :institutions do |t|
      t.string :name
      t.string :identifier
      t.string :hostname
      t.string :key
      t.boolean :active
      t.boolean :requested, default: false
      t.boolean :accepted, default: false

      t.timestamps
    end

    Institution.create(name: 'Reed College', key: 'Reed', identifier: 'd750cf3187352e65ff9ef3268ca7ec42', hostname: 'pearl.local', active: true)
    Institution.create(name: 'Carleton College', key: 'Carleton', identifier: SecureRandom.hex, hostname: 'moodle.carleton.edu', active: true)
  end

  def down
    drop_table :institutions
  end
end
