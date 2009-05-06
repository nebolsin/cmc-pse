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
    executeRemoteCommand('init')
  end

  def install(algorithm)
    copyFile(algorithm.sources.path)
    executeRemoteCommand('installAlgorithm', algorithm.code)
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
    textResults = executeRemoteCommand('queue')
    results = []
    textResults.split(/\s/).each do |taskString|
      taskInfo = taskString.split(/!/)
      results << {:id => taskInfo[0], :user => taskInfo[1], :status => STATES[taskInfo[2]]}
    end
    results
  end

  def test
    copyFile('README')
  end

  def executeRemoteCommand(command, options = '')
    executeRemoteRawCommand("bin/#{command} #{options}")
  end

  def executeRemoteRawCommand(remoteCommand)
    command = "ssh #{host} #{remoteCommand}"
    unless through_host.blank?
      command = "ssh #{through_host} #{command}"
    end
    logger.debug "Executing: #{command}"
    result = `#{command}`
    logger.debug "Result: #{result}"
    return result
  end

  def copyFile(path)
    name = path.split('/')[-1]
    if through_host.blank?
      `scp #{path} #{host}:inbox/`
    else
      `scp #{path} #{through_host}:pse/`
      `ssh #{through_host} scp pse/#{name} #{host}:inbox/ `
    end
  end
end
