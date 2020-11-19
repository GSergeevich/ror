class Station
  attr_reader :title

  def initialize(title)
    @title = title
    @depot = { cargo: [], pass: [] }
  end

  def receive(train)
    @depot[train.type.to_sym] << train
    self
  end

  def send(train)
    @depot[train.type.to_sym].delete(train)
  end

  def trains
    @depot.each { |_type, trains| puts trains }
  end

  def trains_number
    puts "Грузовых: #{@depot[:cargo].length}"
    puts "Пассажирских: #{@depot[:pass].length}"
  end
end
