# frozen_string_literal: true

require_relative 'train'

class CargoTrain < Train
  validate :number, :presence
  validate :number, :format, NUMBER_FORMAT
  validate :number, :type, String

  def initialize(number)
    super
    @type = 'cargo'
  end
end
