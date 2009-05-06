class CreateDatas < ActiveRecord::Migration
  def self.up
    create_table :data_files do |t|
      t.string :name
      t.string :description
      t.string :content_file_name
      t.string :content_content_type
      t.integer :content_file_size
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :data_files
  end
end
