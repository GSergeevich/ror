# frozen_string_literal: true

require './modules/accessors'
require './modules/instance_counter'
require './modules/validation'
require './modules/errors'
require './modules/vendor'
require './modules/interface_methods'

class Station
  include InstanceCounter
  include Validation

  TITLE_FORMAT = /[[:alnum:]]+$/.freeze

  validate :title, :presence
  validate :title, :format, TITLE_FORMAT
  validate :title, :type, String

  @@all = {}
  attr_reader :title

  def self.all
    @@all
  end

  def initialize(title)
    @title = title
    validate!
    @depot = { cargo: [], pass: [] }
    @@all[@title] = self
    register_instance
  end

  def receive(train)
    @depot[train.type.to_sym] << train
    self
  end

  def send_train(train)
    @depot[train.type.to_sym].delete(train)
  end

  def trains(&block)
    all_trains = @depot.values.reduce(&:+)
    all_trains.each do |train|
      block.call train
    end
  end

  def trains_number
    puts "Грузовых: #{@depot[:cargo].length}"
    puts "Пассажирских: #{@depot[:pass].length}"
  end
end
