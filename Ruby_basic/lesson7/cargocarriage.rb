require_relative 'carriage'

class CargoCarriage < Carriage
  attr_reader :type

  def initialize(capacity)
    super(capacity)
    @type = 'cargo'
  end

end
