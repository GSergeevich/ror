class Train
  attr_accessor :speed, :current_station
  attr_reader :number, :type, :route

  def initialize(number)
    @number = number.to_s
    @speed = 0
    @carriages = []
  end

  def detach
    @carriages.pop.attached = false if @speed.zero? && @carriages.length.positive? 
  end

  def attach(carriage)
    @speed.zero?  && carriage.type == self.type && !carriage.attached ? @carriages << carriage && carriage.attached = true : false 
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
end

private 

# Вынес в private потому что эти методы не используются непосредственно в текстовом интерфейсе программы.
def first_on_route?(station)
  @route.stations.first == station
end

def last_on_route?(station)
  @route.stations.last == station
end