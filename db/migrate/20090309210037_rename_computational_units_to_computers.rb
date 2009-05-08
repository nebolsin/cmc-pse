class RenameComputationalUnitsToComputers < ActiveRecord::Migration
  def self.up
    rename_table :computational_units, :computers
  end

  def self.down
    rename_table :computers, :computational_units
  end
end
