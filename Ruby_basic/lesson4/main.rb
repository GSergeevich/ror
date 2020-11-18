require_relative 'cargocarriage'
require_relative 'cargotrain'
require_relative 'passcarriage'
require_relative 'passtrain'
require_relative 'route'
require_relative 'station'
require_relative 'train'

def create(item)
  case item
    when '1'
      puts 'Введите название станции:'
      title = gets.chomp 
      @stations[title] = Station.new(title)

    when '2'
      puts 'Введите номер поезда:'
      number = gets.chomp 
      puts <<~EOM
        Введите тип поезда: 
	    1)пассажирский
	    2)грузовой
	  EOM
	  type = gets.chomp 
	  case type
	    when '1'
	      @trains[number] = PassTrain.new(number)
	    when '2'
	      @trains[number] = CargoTrain.new(number)
	  end
	
	when '3'
	  puts 'Введите название маршрута:'
	  title = gets.chomp
	  puts 'Введите начальную станцию маршрута:'
	  first = @stations[gets.chomp]
	  puts 'Введите конечную станцию маршрута:'
	  last = @stations[gets.chomp]
  	  @routes[title] = Route.new(first,last)
  end
end

@stations = {}
@routes = {}
@trains = {}

puts 'Программа управления железной дорогой.'

while true do
puts 'Выберите действие(введите номер):'
puts <<~EOM
  1) Создать станцию, поезд или маршрут
  2) Добавить или удалить станцию из/в маршрут(а)
  3) Назначать маршрут поезду
  4) Добавить или отцепить вагоны
  5) Переместить поезд по маршруту
  6) Вывести список станций
  7) Вывести список поездов на станции
  8) Выход
EOM

input = gets.chomp 

case input
when '1'
  puts 'Выберите тип создаваемого объекта:'
  puts <<~EOM
    1)Станция
    2)Поезд
    3)Маршрут
  EOM
  create(gets.chomp)
 
when '2'
  puts 'Введите название станции для операции с маршрутом:'
  station = @stations[gets.chomp]
  puts 'Введите название маршрута:'
  route = @routes[gets.chomp]
  if route.stations.include? station 
    puts "#{station.title} будет удалена из маршрута"
    route.delete(station)
  else 
    puts "#{station.title} будет добавлена в маршрут"
    route.insert(station) 
  end

when '3'   	  
  puts 'Введите номер поезда:'
  train = @trains[gets.chomp]
  puts 'Введите название маршрута:'
  route = @routes[gets.chomp]
  train.route(route)

when '4'
  puts 'Введите номер поезда'
  train = @trains[gets.chomp]	 
  puts <<~EOM
    Выберите действие:
    1)Прицепить вагон 
    2)Отцепить вагон
  EOM
  input = gets.chomp
  case input
    when '1'
      puts <<~EOM
        Введите тип вагона: 
	    1)пассажирский
	    2)грузовой
	  EOM
	  input = gets.chomp
	  case input
	  when '1'
        train.attach(PassCarriage.new)
	  when '2'
        train.attach(CargoCarriage.new)
	  end
	
	when '2'
      train.detach
    end

when '5'
  puts 'Введите номер поезда'
  train = @trains[gets.chomp]	 
  puts <<~EOM
    Выберите направление движения:
    1)Вперед по маршруту 
    2)Назад по маршруту
  EOM
  input = gets.chomp
  case input
    when '1'
      train.forward	
	when '2'
      train.backward
  end
	 
when '6'
  puts "Список станций: #{@stations.keys}"

when '7'
	puts 'Введите название станции:'
	@stations[gets.chomp].trains

when '8'
	break
end

end