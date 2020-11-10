class Route
  attr_reader :stations

  def initialize(first_station, last_station)
    @stations = first_station, last_station
  end

  def insert(station)
    @stations.insert(-2, station)
  end

  def delete(station)
    @stations.delete(station) if @stations[1...-1].include?(station)
  end
end
