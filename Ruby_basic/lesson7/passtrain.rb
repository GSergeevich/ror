# frozen_string_literal: true

require_relative 'train'

class PassTrain < Train
  validate :number, :presence
  validate :number, :format, NUMBER_FORMAT
  validate :number, :type, String

  def initialize(number)
    super
    @type = 'pass'
  end
end
