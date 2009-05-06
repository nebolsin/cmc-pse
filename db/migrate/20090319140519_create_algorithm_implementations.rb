class CreateAlgorithmImplementations < ActiveRecord::Migration
  def self.up
    create_table :algorithm_implementations do |t|
      t.string :name
      t.text :description
      t.integer :algorithm_id
      t.integer :language_id
      t.integer :user_id
      t.string :sources_file_name
      t.string :sources_content_type
      t.integer :sources_file_size

      t.timestamps
    end
  end

  def self.down
    drop_table :algorithm_implementations
  end
end
