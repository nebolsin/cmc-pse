class AddAttachmentToAlgorithm < ActiveRecord::Migration
  def self.up
    add_column :algorithms, :sources_file_name, :string
    add_column :algorithms, :sources_content_type, :string
    add_column :algorithms, :sources_file_size, :integer
  end

  def self.down
    remove_column :algorithms, :sources_file_size
    remove_column :algorithms, :sources_content_type
    remove_column :algorithms, :sources_file_name
  end
end
