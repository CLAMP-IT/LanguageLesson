class CreateRecordings < ActiveRecord::Migration
  def change
    create_table :recordings do |t|
      t.attachment :file
      t.references :recordable, :polymorphic => true
      t.string :recording_type, limit: 30
      t.timestamps
    end
  end
end
