class CreateComponentsComputers < ActiveRecord::Migration
  def self.up
    create_table :components_computers do |t|
      t.integer :component_id
      t.integer :computer_id
    end
  end

  def self.down
    drop_table :components_computers
  end
end
