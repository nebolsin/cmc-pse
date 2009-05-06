class CreateAlgorithms < ActiveRecord::Migration
  def self.up
    create_table :algorithms do |t|
      t.string :code
      t.string :name
      t.text :description
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :algorithms
  end
end
