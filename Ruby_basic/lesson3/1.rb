#! /usr/bin/env ruby

class Station

	def initialize(title)
      @title = title
      @depot = {cargo: [],passengers: []}
	end

	def receive(train)
		@depot[train.type.to_sym] << train
	end

	def send(train)
		@depot[train.type.to_sym].delete(train)
	end

	def trains
		@depot.each {|type,trains| puts trains}
	end

	def trains_number
		puts "Грузовых: #{@depot[:cargo].length}"
		puts "Пассажирских: #{@depot[:passengers].length}"
	end

end

class Route
	
	attr_reader :stations

	def initialize(first_station,last_station)
      @stations = first_station,last_station
    end

	def insert(station)
		@stations.insert(-2,station)
	end

	def delete(station)
		@stations.delete(station) if @stations.include?(station)
	end

end

class Train
  
  attr_accessor :speed
  attr_reader :carriages, :type

  def initialize(number,type,carriages)
  	@number= number.to_s
  	@type = type # 'cargo' or 'passengers'
  	@carriages = carriages
  end

  def detach
    @carriages -= 1 if @speed == 0 
  end

  def attach
    @carriages += 1 if @speed == 0 
  end

  def route(route)
  	@route = route
  	@current_station_index = 0 
  	@route.stations[@current_station_index].receive(self)
  	p @route.stations[@current_station_index].trains #debug
  end

  def forward
  	@route.stations[@current_station_index].send(self)
  	@current_station_index += 1
  	@route.stations[@current_station_index].receive(self)
  	p @route.stations[@current_station_index].trains #debug
  end

  def backward
  	@route.stations[@current_station_index].send(self)
  	@current_station_index += 1
  	@route.stations[@current_station_index].recieve(self)
  	p @route.stations[@current_station_index].trains #debug
  end

end


station1 = Station.new('Lud')
station2 = Station.new('Candleton')
station3 = Station.new('Rilea')
station4 = Station.new('Dasherville')
station5 = Station.new('Topeka')

r1 = Route.new(station1,station5)
p r1.stations
puts "-----"
r1.insert(station2)
p r1.stations
puts "-----"
r1.insert(station3)
p r1.stations
puts "-----"
r1.insert(station4)
p r1.stations
puts "-----"
r1.delete(station4)
p r1.stations
puts "-----"
r1.insert(station4)
p r1.stations
puts "-----"

blaine_the_mono = Train.new(1,'passengers',4)
blaine_the_mono.route(r1)
blaine_the_mono.attach
blaine_the_mono.carriages
blaine_the_mono.detach
blaine_the_mono.carriages
blaine_the_mono.speed 
blaine_the_mono.speed= 1225
blaine_the_mono.detach
blaine_the_mono.carriages
blaine_the_mono.forward
puts "-----"
blaine_the_mono.forward
puts "-----"
blaine_the_mono.speed
blaine_the_mono.speed= 0
blaine_the_mono.speed= 1225
blaine_the_mono.forward
puts "-----"
blaine_the_mono.speed= 1500
blaine_the_mono.speed= 1700









