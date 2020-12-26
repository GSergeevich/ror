# frozen_string_literal: true

require_relative 'modules'

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
