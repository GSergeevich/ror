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
      puts @stations[title] ?  "Станция #{title} уже существует" : "Станция " + (@stations[title] = Station.new(title)).title + " создана."

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
	     puts @trains[number] ? "Поезд номер #{number} уже существует." : "Поезд " + (@trains[number] = PassTrain.new(number)).number + " создан."
	    when '2'
	     puts @trains[number] ? "Поезд номер #{number} уже существует." : "Поезд " + (@trains[number] = CargoTrain.new(number)).number + " создан."
	  end
	
	when '3'
	  puts 'Введите название маршрута:'
	  title = gets.chomp
	  puts 'Введите начальную станцию маршрута:'
	  first = @stations[gets.chomp]
	  puts 'Введите конечную станцию маршрута:'
	  last = @stations[gets.chomp]
  	  puts @routes[title] ? "Маршрут #{title} уже существует." : "Маршрут " + (@routes[title] = Route.new(first,last)).title + " создан."
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
    puts route.delete(station) ? "#{station.title} удалена из маршрута" :  "#{station.title} является терминальной станцией маршрута,удаление невозможно"
 
  else 
    puts route.insert(station) ? "#{station.title} добавлена в маршрут" : "Что-то пошло не так.Убедитесь в корректности ввода"
  end

when '3'   	  
  puts 'Введите номер поезда:'
  train = @trains[gets.chomp]
  puts 'Введите название маршрута:'
  route = @routes[gets.chomp]
  puts train && route ? "Поезду #{train} присвоен маршрут: #{train.route!(route)}" : 'Что-то пошло не так.Убедитесь в корректности ввода'

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
      puts train.attach(PassCarriage.new) ? 'Вагон прицеплен' : 'Операция не выполнена.Проверьте корректность ввода'
	  when '2'
      puts train.attach(CargoCarriage.new) ? 'Вагон прицеплен' : 'Операция не выполнена.Проверьте корректность ввода'
	  end
	
	when '2'
      puts train.detach ? 'Вагон отцеплен' : 'Операция не выполнена.Проверьте корректность ввода'
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
      puts train.route ? "Станция #{train.forward}" : "Поезду не назначен маршрут"	
	when '2'
      puts train.route ? "Станция #{train.backward}" : "Поезду не назначен маршрут" 
  end
	 
when '6'
  puts "Список станций: #{@stations.keys}"

when '7'
	puts 'Введите название станции:'
  station = @stations[gets.chomp]
	puts station ? station.trains : "Станции не существует"

when '8'
	break
end

end