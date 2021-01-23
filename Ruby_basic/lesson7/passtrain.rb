# frozen_string_literal: true

require_relative 'train'

class PassTrain < Train
  validate :number, :presense
  validate :number, :format, NUMBER_FORMAT
  validate :number, :type, Integer 
  
  def initialize(number)
    super
    @type = 'pass'
  end
end
