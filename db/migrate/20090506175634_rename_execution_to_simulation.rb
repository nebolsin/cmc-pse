class RenameExecutionToSimulation < ActiveRecord::Migration
  def self.up
    rename_table :executions, :simulations
  end

  def self.down
    rename_table :simulations, :executions
  end
end
