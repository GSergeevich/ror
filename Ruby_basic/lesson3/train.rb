class Train
  attr_accessor :speed, :current_station
  attr_reader :carriages, :type, :number

  def initialize(number, type, carriages)
    @number = number.to_s
    @type = type # 'cargo' or 'passengers'
    @carriages = carriages
    @speed = 0
  end

  def detach
    @carriages -= 1 if @speed.zero?
    @carriages
  end

  def attach
    @carriages += 1 if @speed.zero?
    @carriages
  end

  def route(route)
    @route = route
    @current_station = @route.stations[0]
    @current_station.receive(self)
    @route.stations.map(&:title)
  end

  def forward
    @current_station.send(self)
    @current_station = next_station.receive(self)
    @current_station.title
  end

  def backward
    @current_station.send(self)
    @current_station = prev_station.recieve(self)
    @current_station.title
  end

  def next_station
    index = @route.stations.index(@current_station)
    @route.stations[index + 1]
  end

  def prev_station
    index = @route.stations.index(@current_station)
    @route.stations[index - 1]
  end
end
