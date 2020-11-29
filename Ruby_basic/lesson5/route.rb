class Route
  include InstanceCounter
  attr_reader :stations
  @@routes = {}
  
  def self.all
    @@routes
  end

  def initialize(name, first_station, last_station)
    @name = name
    @stations = first_station, last_station
    @@routes[name] = self
    register_instance
  end

  def insert(station)
    @stations.insert(-2, station)
  end

  def delete(station)
    @stations.delete(station) if @stations[1...-1].include?(station)
  end
end
