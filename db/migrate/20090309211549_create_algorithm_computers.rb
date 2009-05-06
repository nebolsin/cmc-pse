class CreateAlgorithmComputers < ActiveRecord::Migration
  def self.up
    create_table :algorithms_computers do |t|
      t.integer :algorithm_id
      t.integer :computer_id
    end
  end

  def self.down
    drop_table :algorithms_computers
  end
end
