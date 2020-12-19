require_relative 'modules'
NUMBER_FORMAT = /\w{3}(-)*\w{2}$/

class Train
  @@all = {}
  include Vendor
  include InstanceCounter
  attr_accessor :speed, :current_station
  attr_reader :number, :type, :route , :carriages

  def self.find(number)
    @@all[number.to_s]
  end

  def self.all
    @@all
  end

  def initialize(number)
    @number = number.to_s
    validate @number
    @speed = 0
    @carriages = []
    @@all[@number] = self
    register_instance
  end

  def allcarriages
    @carriages.each do |carriage|
      yield carriage
    end
  end

  def detach
    @carriages.pop if @speed.zero?
  end

  def attach(carriage)
    @speed.zero? && carriage.type == type && !carriage.attached ? @carriages << carriage && carriage.attached = true : false
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
      @current_station.send(self)
      @current_station = next_station.receive(self)
      @current_station.title
    end
  end

  def backward
    if first_on_route?(@current_station)
      "#{@current_station.title} первая на маршруте"
    else
      @current_station.send(self)
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

  def valid?(number)
    validate number
    true
  rescue RuntimeError
    false
  end

  private

  def validate(number)
    raise TrainTitleError if number !~ NUMBER_FORMAT
    raise InstanceExistError if Train.find(number)
  end

  def first_on_route?(station)
    @route.stations.first == station
  end

  def last_on_route?(station)
    @route.stations.last == station
  end
end