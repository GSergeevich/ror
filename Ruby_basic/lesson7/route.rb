# frozen_string_literal: true

class Route
  include InstanceCounter
  include Validation
  attr_reader :stations

  TITLE_FORMAT = /[[:alnum:]]+/.freeze

  validate :name, :presence
  validate :name, :format, TITLE_FORMAT
  validate :name, :type, String
  @@routes = {}

  def self.all
    @@routes
  end

  def initialize(name, first_station, last_station)
    @name = name
    validate!
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
