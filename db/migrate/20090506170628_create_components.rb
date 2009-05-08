class CreateComponents < ActiveRecord::Migration
  def self.up
    create_table :components do |t|
      t.string :name
      t.text :description
      t.string :user_id
      t.string :sources_file_name
      t.string :sources_content_type
      t.integer :sources_file_size

      t.timestamps
    end
  end

  def self.down
    drop_table :components
  end
end
