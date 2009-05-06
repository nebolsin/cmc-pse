class RenameComputationalUnitsToComputers < ActiveRecord::Migration
  def self.up
    rename_table :computers, :computers
  end

  def self.down
    rename_table :computers, :computers
  end
end
