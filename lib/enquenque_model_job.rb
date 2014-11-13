class EnquenqueModelJob
  include Resque::Plugins::Status
  
  @queue = :imports
  attr_accessor :message
  
  def self.perform(options={})
    begin
      class_name = Object.const_get(options['object'])
      return unless object = class_name.find(options['id'])
      object.send(options['action'])
    rescue
      'wrong class name'
    end
  end
end

