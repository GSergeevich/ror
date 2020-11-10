#! /usr/bin/env ruby

class Station
  attr_reader :title

  def initialize(title)
    @title = title
    @depot = { cargo: [], passengers: [] }
  end

  def receive(train)
    @depot[train.type.to_sym] << train
  end

  def send(train)
    @depot[train.type.to_sym].delete(train)
  end

  def trains
    @depot.each { |_type, trains| puts trains }
  end

  def trains_number
    puts "Грузовых: #{@depot[:cargo].length}"
    puts "Пассажирских: #{@depot[:passengers].length}"
  end
end

class Route
  attr_reader :stations

  def initialize(first_station, last_station)
    @stations = first_station, last_station
  end

  def insert(station)
    @stations.insert(-2, station)
  end

  def delete(station)
    @stations.delete(station) if @stations.include?(station)
  end
end

class Train
  attr_accessor :speed
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
    @current_station_index = 0
    @route.stations[@current_station_index].receive(self)
    @route.stations.map(&:title)
  end

  def forward
    @route.stations[@current_station_index].send(self)
    @current_station_index += 1
    @route.stations[@current_station_index].receive(self)
    @route.stations[@current_station_index].title
  end

  def backward
    @route.stations[@current_station_index].send(self)
    @current_station_index += 1
    @route.stations[@current_station_index].recieve(self)
    @route.stations[@current_station_index].title
  end

  def near_stations
    index = @current_station_index
    @route.stations[(index - 1)..(index + 1)].map(&:title)
  end
end
