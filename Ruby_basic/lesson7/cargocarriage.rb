require_relative 'carriage'

class CargoCarriage < Carriage
  attr_reader :type, :occupied

  def initialize(capacity)
    @capacity = capacity
    @occupied = 0
    @type = 'cargo'
  end

  def occupy!(number)
    @occupied + number <= @capacity ? @occupied += number : false
  end

  def free?
    @capacity - @occupied
  end
end
