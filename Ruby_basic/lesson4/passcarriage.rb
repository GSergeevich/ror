require_relative 'carriage'

class PassCarriage < Carriage
  attr_reader :type
  
  def initialize
      @type = 'pass'
	end


end
