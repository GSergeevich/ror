# frozen_string_literal: true

require './modules/accessors'
require './modules/instance_counter'
require './modules/validation'
require './modules/errors'
require './modules/vendor'
require './modules/interface_methods'

class Carriage
  include Vendor
  attr_reader :occupied
  attr_accessor :attached

  def initialize(capacity)
    @capacity = capacity
    @occupied = 0
  end

  def occupy!(number)
    @occupied + number <= @capacity ? @occupied += number : false
  end

  def free?
    @capacity - @occupied
  end
end
