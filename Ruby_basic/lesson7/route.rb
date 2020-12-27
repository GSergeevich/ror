# frozen_string_literal: true

class Route
  include InstanceCounter
  attr_reader :stations

  TITLE_FORMAT = /\w+/.freeze

  @@routes = {}

  def self.all
    @@routes
  end

  def initialize(name, first_station, last_station)
    validate name
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

  def valid?(title)
    validate title
    true
  rescue RuntimeError
    false
  end

  private

  def validate(title)
    raise TitleError if title !~ TITLE_FORMAT
    raise InstanceExistError if @@routes[title]
  end
end
