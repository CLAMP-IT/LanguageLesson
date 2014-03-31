class CreateRecordings < ActiveRecord::Migration
  def change
    create_table :recordings do |t|
      t.attachment :file
      t.references :recordable, :polymorphic => true
      
      t.timestamps
    end
  end
end
