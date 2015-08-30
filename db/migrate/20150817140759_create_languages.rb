class CreateLanguages < ActiveRecord::Migration
  def change
    create_table :languages do |t|
      t.string :name
      t.string :image

      t.timestamps
    end

    add_column :lessons, :language_id, :integer
    
    %w{Chinese Japanese Arabic}.each { |language_name| Language.create name: language_name }
  end
end
