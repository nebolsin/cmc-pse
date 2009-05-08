class CreateExecutions < ActiveRecord::Migration
  def self.up
    create_table :executions do |t|
      t.integer :user_id
      t.integer :component_id
      t.integer :computer_id
      t.string :job_id
      t.string :status
      t.integer :result_id

      t.timestamps
    end
  end

  def self.down
    drop_table :executions
  end
end
