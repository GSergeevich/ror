# frozen_string_literal: true

require_relative 'carriage'

class PassCarriage < Carriage
  attr_reader :type

  def initialize(capacity)
    super(capacity)
    @type = 'pass'
  end

  def occupy!
    @occupied < @capacity ? @occupied += 1 : false
  end
end
