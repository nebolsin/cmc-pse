class AddUsernameToComputer < ActiveRecord::Migration
  def self.up
    add_column :computers, :username, :string
  end

  def self.down
    remove_column :computers, :username
  end
end
