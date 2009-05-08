# == Schema Information
# Schema version: 20090506170628
#
# Table name: executions
#
#  id           :integer         not null, primary key
#  user_id      :integer
#  component_id :integer
#  computer_id  :integer
#  job_id       :string(255)
#  status       :string(255)
#  result_id    :integer
#  created_at   :datetime
#  updated_at   :datetime
#

class Simulation < ActiveRecord::Base

  belongs_to :computer
  belongs_to :user
  belongs_to :component
  belongs_to :result, :class_name => 'DataFile'


  def is_completed?
    self.status == 'C'
  end

  def status_name
    Computer::STATES[self.status]
  end

  def update_status
    unless is_completed?
      queue = computer.queue
      finished = true
      queue.each do |item|
        if item[:id] == job_id
          finished = false
          self.status = item[:status]
        end
      end
      self.status = 'C' if finished
      save
    end
  end

  def cancel!
    computer.cancel_job(@simulation.job_id)
    self.status = 'C'
    save
  end

  def retrieve_result
    (result, error) = computer.retrieve_result(self)
    self.result = DataFile.create(
        :name => "Результат имитации ##{self.id}",
        :description => "Компонент: #{self.component.name}\nДата запуска: #{self.created_at}",
        :user => self.user,
        :content => result
    )
    save
  end
end
