# frozen_string_literal: true

require './modules/accessors'
require './modules/instance_counter'
require './modules/validation'
require './modules/errors'
require './modules/vendor'
require './modules/interface_methods'

class Train
  NUMBER_FORMAT = /\w{3}(-)*\w{2}$/.freeze

  @@all = {}
  include Vendor
  include InstanceCounter
  include Validation
  validate :number, :presence
  validate :number, :format, NUMBER_FORMAT
  validate :number, :type, String

  attr_accessor :speed, :current_station
  attr_reader :number, :type, :route, :carriages

  def self.find(number)
    @@all[number]
  end

  def self.all
    @@all
  end

  def initialize(number)
    @number = number
    validate!
    @speed = 0
    @carriages = []
    @@all[@number] = self
    register_instance
  end

  def allcarriages(&block)
    @carriages.each do |carriage|
      block.call carriage
    end
  end

  def detach
    @carriages.pop if @speed.zero?
  end

  def attach(carriage)
    if @speed.zero? && carriage.type == type && !carriage.attached
      carriage.attached = true
      @carriages << carriage
    else
      false
    end
  end

  def route!(route)
    @route = route
    @current_station = @route.stations[0]
    @current_station.receive(self)
    @route.stations.map(&:title)
  end

  def forward
    if last_on_route?(@current_station)
      "#{@current_station.title} последняя на маршруте"
    else
      @current_station.send_train(self)
      @current_station = next_station.receive(self)
      @current_station.title
    end
  end

  def backward
    if first_on_route?(@current_station)
      "#{@current_station.title} первая на маршруте"
    else
      @current_station.send_train(self)
      @current_station = prev_station.receive(self)
      @current_station.title
    end
  end

  def next_station
    return nil if last_on_route?(@current_station)

    index = @route.stations.index(@current_station)
    @route.stations[index + 1]
  end

  def prev_station
    return nil if first_on_route?(@current_station)

    index = @route.stations.index(@current_station)
    @route.stations[index - 1]
  end

  private

  def first_on_route?(station)
    @route.stations.first == station
  end

  def last_on_route?(station)
    @route.stations.last == station
  end
end
