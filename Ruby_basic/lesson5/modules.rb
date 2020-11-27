module NS
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    def debug(log)
      puts "DEBUG: #{log}"
    end
  end

  module InstanceMethods
    def debug(log)
      puts "DEBUG(instance: #{self}): #{log} "
    end
  end
end

module Vendor
  attr_accessor :vendor
end