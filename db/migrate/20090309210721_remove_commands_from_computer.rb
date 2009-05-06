class RemoveCommandsFromComputer < ActiveRecord::Migration
  def self.up
    remove_column :computers, :taskSubmitCommand
    remove_column :computers, :viewQueueCommand
  end

  def self.down
    add_column :computers, :taskSubmitCommand, :string
    add_column :computers, :viewQueueCommand, :string
  end
end
