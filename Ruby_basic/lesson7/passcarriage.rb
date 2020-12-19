require_relative 'carriage'

class PassCarriage < Carriage
  attr_reader :type
  attr_accessor :occupied

  def initialize(seats)
    @seats = seats
    @occupied = 0
    @type = 'pass'
  end

  def occupy!
    @occupied < @seats ? @occupied += 1 : false
  end

  def free?
    @seats - @occupied
  end
end
