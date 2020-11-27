class Interface
  
  def initialize
    puts 'Программа управления железной дорогой.'
    run
  end

  def run
    loop do
      puts <<~EOM

        Выберите действие(введите номер):
        1) Создать станцию, поезд или маршрут
        2) Добавить или удалить станцию из/в маршрут(а)
        3) Назначать маршрут поезду
        4) Добавить или отцепить вагоны
        5) Переместить поезд по маршруту
        6) Вывести список станций
        7) Вывести список поездов на станции
        8) Выход
      EOM

      case gets.chomp
      when '1'
        create!

      when '2'
        route_change!

      when '3'
        route_set!

      when '4'
        carriage_ops!

      when '5'
        train_move!

      when '6'
        station_list

      when '7'
        station_trains

      when '8'
        break
      end
    end
  end

  protected

  def create!
    puts 'Выберите тип создаваемого объекта:'
    puts <<~EOM
      1)Станция
      2)Поезд
      3)Маршрут
    EOM

    case gets.chomp
    when '1'
      puts 'Введите название станции:'
      title = gets.chomp
      puts Station.all[title] ? "Станция #{title} уже существует" : 'Станция ' + Station.new(title).title + ' создана.'

    when '2'
      puts 'Введите номер поезда:'
      number = gets.chomp
      if Train.find(number)
        puts "Поезд номер #{number} уже существует."
      else
        puts <<~EOM
          Введите тип поезда: 
          1)пассажирский
          2)грузовой
        EOM
        type = gets.chomp
        case type
        when '1'
          puts "Поезд #{PassTrain.new(number).number} создан."
        when '2'
          puts "Поезд #{CargoTrain.new(number).number} создан."
        end
      end

    when '3'
      puts 'Введите название маршрута:'
      title = gets.chomp
      if Route.all[title]
        puts "Маршрут #{title} уже существует."
      else
        puts 'Введите начальную станцию маршрута:'
        first = Station.all[gets.chomp]  
        puts 'Введите конечную станцию маршрута:'
        last = Station.all[gets.chomp]
        puts "Маршрут #{Route.new(title, first, last).title} создан."
      end
    end
  end

  def route_change!
    puts 'Введите название станции для операции с маршрутом:'
    station = Station.all[gets.chomp]
    puts 'Введите название маршрута:'
    route = Route.all[gets.chomp]
    if route.stations.include? station
      puts route.delete(station) ? "#{station.title} удалена из маршрута" : "#{station.title} является терминальной станцией маршрута,удаление невозможно"
    else
      puts route.insert(station) ? "#{station.title} добавлена в маршрут" : 'Что-то пошло не так.Убедитесь в корректности ввода'
    end
  end

  def route_set!
    puts 'Введите номер поезда:'
    train = Train.trains[gets.chomp.to_s]
    puts 'Введите название маршрута:'
    route = Route.all[gets.chomp]
    puts train && route ? "Поезду #{train.number} присвоен маршрут: #{train.route!(route)}" : 'Что-то пошло не так.Убедитесь в корректности ввода'
  end

  def carriage_ops!
    puts 'Введите номер поезда'
    train = Train.trains[gets.chomp.to_s]
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
  end

  def train_move!
    puts 'Введите номер поезда'
    train = Train.trains[gets.chomp.to_s]
    puts <<~EOM
      Выберите направление движения:
      1)Вперед по маршруту 
      2)Назад по маршруту
    EOM
    input = gets.chomp
    case input
    when '1'
      puts train.route ? "Станция #{train.forward}" : 'Поезду не назначен маршрут'
    when '2'
      puts train.route ? "Станция #{train.backward}" : 'Поезду не назначен маршрут'
    end
  end

  def station_trains
    puts 'Введите название станции:'
    station = Station.all[gets.chomp]
    puts station ? station.trains : 'Станции не существует'
  end

  def station_list
    puts Station.all.keys.tap{|output| puts 'Станций не найдено' if output == []} 
  end
end
