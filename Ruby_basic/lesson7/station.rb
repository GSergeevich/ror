class Station
  include InstanceCounter
  TITLE_FORMAT = /\w+$/.freeze

  @@all = {}
  attr_reader :title

  def self.all
    @@all
  end

  def initialize(title)
    @title = title
    validate title
    @depot = { cargo: [], pass: [] }
    @@all[@title] = self
    register_instance
  end

  def receive(train)
    @depot[train.type.to_sym] << train
    self
  end

  def send(train)
    @depot[train.type.to_sym].delete(train)
  end

  def trains
    all_trains = @depot.values.reduce([]) { |arr, type| arr |= type }
    all_trains.each do |train|
      yield train
    end
  end

  def trains_number
    puts "Грузовых: #{@depot[:cargo].length}"
    puts "Пассажирских: #{@depot[:pass].length}"
  end

  def valid?(title)
    validate title
    true
  rescue RuntimeError
    false
  end

  protected

  def validate(title)
    raise StationTitleError if title !~ TITLE_FORMAT
    raise InstanceExistError if @@all[title]
  end
end
