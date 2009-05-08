class CreateComputationalUnits < ActiveRecord::Migration
  def self.up
    create_table :computational_units do |t|
      t.string :name
      t.string :host
      t.text :description
      t.string :throughHost
      t.string :workingDirectory
      t.string :taskSubmitCommand
      t.string :viewQueueCommand

      t.timestamps
    end
  end

  def self.down
    drop_table :computational_units
  end
end
