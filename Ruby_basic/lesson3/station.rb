class Station
  attr_reader :title

  def initialize(title)
    @title = title
    @depot = { cargo: [], passengers: [] }
  end

  def receive(train)
    @depot[train.type.to_sym] << train
    self
  end

  def send(train)
    @depot[train.type.to_sym].delete(train)
  end

  def trains
    @depot.each { |type, trains| puts trains }
  end

  def trains_number
    puts "Грузовых: #{@depot[:cargo].length}"
    puts "Пассажирских: #{@depot[:passengers].length}"
  end
end
