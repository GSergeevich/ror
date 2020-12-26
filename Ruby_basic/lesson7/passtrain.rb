# frozen_string_literal: true

require_relative 'train'

class PassTrain < Train
  def initialize(number)
    super
    @type = 'pass'
  end
end
