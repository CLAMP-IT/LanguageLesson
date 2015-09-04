class CreateRecordings < ActiveRecord::Migration
  def change
    create_table :recordings do |t|
      t.string :url
      t.string :bucket_name, limit: 40
      t.string :uuid
      t.string :file_name
      t.integer :file_size
      t.string :content_type
      t.references :recordable, :polymorphic => true
      t.string :recording_type, limit: 30
      t.timestamps
    end
  end
end
