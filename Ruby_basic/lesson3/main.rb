require_relative 'cargocarriage'
require_relative 'cargotrain'
require_relative 'passcarriage'
require_relative 'passtrain'
require_relative 'route'
require_relative 'station'
require_relative 'train'


stations = {}
routes = {}
trains = {}

puts 'Программа управления железной дорогой.'

while true do
puts 'Выберите действие(введите номер):'
puts <<~EOM
  1) Создать станцию
  2) Создать поезд
  3) Создать маршрут
  4) Добавить или удалить станцию из/в маршрут(а)
  5) Назначать маршрут поезду
  6) Добавить или отцепить вагоны
  7) Переместить поезд по маршруту
  8) Вывести список станций
  9) Вывести список поездов на станции
  10) Выход
EOM

input = gets.chomp 

case input
when '1'
  puts 'Введите название станции:'
  title = gets.chomp 
  stations[title] = Station.new(title)

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
	  trains[title] = PassTrain.new(number)
    when '2'
      trains[title] = CargoTrain.new(number)
  end

when '3'
  puts 'Введите название маршрута:'
  title = gets.chomp
  puts 'Введите начальную станцию маршрута:'
  first = gets.chomp
  puts 'Введите конечную станцию маршрута:'
  last = gets.chomp
  routes[title] = Route.new(first,last)

when '4'
  puts 'Введите название станции для операции с маршрутом:'
  station = stations[gets.chomp]
  puts 'Введите название маршрута:'
  route = routes[gets.chomp]
  if route.stations.include? station 
    puts "#{station.title} будет удалена из маршрута"
    route.delete(station)
  else 
    puts "#{station.title} будет добавлена в маршрут"
    route.insert(station) 
  end

when '5'   	  
  puts 'Введите название станции для :'
  station = gets.chomp
  puts 'Введите название маршрута:'
  route = gets.chomp
  routes[route].insert(station)


when '8'
  puts "Список станций: #{stations.keys}"

when '10'
	break
end

end