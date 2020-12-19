module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    attr_accessor :instances
  end

  module InstanceMethods
    private

    def register_instance
      self.class.instances ||= 0
      self.class.instances += 1
    end
  end
end

module Vendor
  attr_accessor :vendor
end

class InstanceTypeError < RuntimeError
end

class TrainTitleError < RuntimeError
end

class StationTitleError < RuntimeError
end

class RouteTitleError < RuntimeError
end

class InstanceExistError < RuntimeError
end

class InstanceNotExistError < RuntimeError
end
