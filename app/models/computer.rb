# == Schema Information
# Schema version: 20090309211039
#
# Table name: computers
#
#  id                :integer         not null, primary key
#  name              :string(255)
#  host              :string(255)
#  description       :text
#  through_host      :string(255)
#  working_directory :string(255)
#  created_at        :datetime
#  updated_at        :datetime
#

class Computer < ActiveRecord::Base
  has_and_belongs_to_many :algorithms
  
  def init
    execute_remote_command('init')
  end

  def install_component(component)
    copy_file(component.sources.path)
    execute_remote_command('install_component', [component.id])
  end

  def uninstall_component(component)
    execute_remote_command('uninstall_component', [component.id])
  end

  def simulate(simulation)
    job_id = execute_remote_command('simulate', [simulation.id, simulation.component.id])
    simulation.job_id = job_id.strip.gsub(/"/,'')
    simulation.save
  end

  def cancel_job(job_id)
    execute_remote_command('cancel_job', [job_id])
  end

  def retrieve_result(simulation)
    execute_remote_command('retrieve_result', [simulation.id])
    result = retrieve_file("#{simulation.id}.out")
    error = retrieve_file("#{simulation.id}.err")
    [result, error]
  end

  STATES = {
    'R' => 'Выполняется',
    'ST' =>  'Запускается',
    'P' => 'Начат процесс запуска',
    'I' => 'Ожидает запуска',
    'H' => 'Приостановлена пользователем',
    'NQ' => 'Не готово к запуску',
    'C' => 'Завершено'
  }

  def queue
    text_results = execute_remote_command('queue')
    results = []
    unless text_results =~ /.*There is currently no job status to report.*/
      text_results.split(/\s/).each do |task_string|
        task_info = task_string.split(/!/)
        results << {:id => task_info[0], :user => task_info[1], :status => task_info[2], :status_name => STATES[task_info[2]], :simulation => Simulation.find_by_job_id(task_info[0])}
      end
    end
    results
  end

  def test
    copy_file('README')
  end

  def full_host_name
    return "#{username}@#{host}" unless username.blank?
    host
  end

  def execute_remote_command(command, options = [])
    execute_remote_raw_command("bin/#{command} #{options.join(' ')}")
  end

  def execute_remote_raw_command(remote_command)
    command = "ssh #{full_host_name} #{remote_command}"
    unless through_host.blank?
      command = "ssh #{through_host} #{command}"
    end
    logger.debug "Executing: #{command}"
    result = `#{command}`
    logger.debug "Result: #{result}"
    return result
  end

  def copy_file(path)
    name = path.split('/')[-1]
    if through_host.blank?
      `scp #{path} #{full_host_name}:inbox/`
    else
      `scp #{path} #{through_host}:pse/`
      `ssh #{through_host} scp pse/#{full_host_name} #{host}:inbox/ `
    end
  end
  
  def retrieve_file(name)
    if through_host.blank?
      `scp #{full_host_name}:outbox/#{name} #{RAILS_ROOT}/public/`
    else
      `ssh #{through_host} scp #{full_host_name}:outbox/#{name} pse/outbox/`
      `scp #{through_host}:pse/outbox/#{name} #{RAILS_ROOT}/public/`
    end

    File.new("#{RAILS_ROOT}/public/#{name}")
  end
end
