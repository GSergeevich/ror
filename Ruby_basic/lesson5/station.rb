class Station
  @@all = {}
  attr_reader :title
  
  def self.all
    @@all
  end

  def initialize(title)
    @title = title
    @depot = { cargo: [], pass: [] }
    @@all[@title] = self
  end

  def receive(train)
    @depot[train.type.to_sym] << train
    self
  end

  def send(train)
    @depot[train.type.to_sym].delete(train)
  end

  def trains
    arr = []
    @depot[:cargo].each { |train| arr << train.number.to_s }
    @depot[:pass].each { |train| arr << train.number.to_s }
    arr
  end

  def trains_number
    puts "Грузовых: #{@depot[:cargo].length}"
    puts "Пассажирских: #{@depot[:pass].length}"
  end
end
