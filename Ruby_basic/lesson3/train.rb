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

  def first_on_route?(station)
    @route.stations.first == station
  end

  def last_on_route?(station)
    @route.stations.last == station
  end
  
  def forward
    if last_on_route?(@current_station)
      "станция #{@current_station.title } последняя на маршруте"
    else  
      @current_station.send(self)
      @current_station = next_station.receive(self)
      @current_station.title
    end
  end

  def backward
    if first_on_route?(@current_station)
      "станция #{@current_station.title } первая на маршруте"
    else  
      @current_station.send(self)
      @current_station = prev_station.recieve(self)
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
end
