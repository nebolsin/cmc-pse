class RenameCamelcaseColumnsInComputer < ActiveRecord::Migration
  def self.up
    rename_column :computers, :workingDirectory, :working_directory
    rename_column :computers, :throughHost, :through_host
  end

  def self.down
    rename_column :computers, :working_directory, :workingDirectory
    rename_column :computers, :through_host, :throughHost
  end
end
