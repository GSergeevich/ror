class Interface
  
  def initialize
    puts 'Программа управления железной дорогой.'
    run
  end

  def run
    loop do
      puts <<~EOM

        Выберите действие(введите номер):
        1) Создать станцию
        2) Создать поезд 
        3) Создать маршрут
        4) Добавить или удалить станцию из/в маршрут(а)
        5) Назначать маршрут поезду
        6) Добавить или отцепить вагоны
        7) Переместить поезд по маршруту
        8) Вывести список станций
        9) Вывести список поездов на станции
        0) Выход
      EOM

      case gets.chomp
      when '1'
        create_station!

      when '2'
        create_train!

      when '3'
        create_route!

      when '4'
        route_change!

      when '5'
        route_set!

      when '6'
        carriage_ops!

      when '7'
        train_move!

      when '8'
        station_list

      when '9'
        station_trains

      when '0'
        break
      end

      rescue TrainTitleError 
        puts 'Некорректный номер поезда,используйте формат: 3 цифры или буквы,опциональный дефис,2 буквы или цифры'
        retry
      rescue  StationTitleError
        puts 'Название станции некорректное,используйте не менее одной буквы или цифры'
        retry
      rescue RouteTitleError
        puts 'Название  маршрута некорректное,используйте не менее одной буквы или цифры'
        retry
      rescue InstanceExistError
        puts 'Объект уже существует'
        retry
      rescue InstanceNotExistError 
        puts 'Объекта не существует'
        retry
      rescue InstanceTypeError 
        puts 'Некорректный ввод, используйте цифры из предложенных вариантов'
        retry
    end
  end

  protected

  def create_station!
    puts 'Введите название станции:'
    title = gets.chomp
    puts 'Станция ' + Station.new(title).title + ' создана.'
  end

  def create_train!
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
        puts "Поезд #{PassTrain.new(number).number} создан."
      when '2'
        puts "Поезд #{CargoTrain.new(number).number} создан."
      else
        raise InstanceTypeError
    end
  end

  def create_route!
    puts 'Введите название маршрута:'
    title = gets.chomp
    puts 'Введите начальную станцию маршрута:'
    raise InstanceNotExistError unless first = Station.all[gets.chomp]  
    puts 'Введите конечную станцию маршрута:'
    raise InstanceNotExistError unless last = Station.all[gets.chomp]
    Route.new(title, first, last)
    puts "Маршрут #{title} создан."
  end

  def route_change!
    puts 'Введите название станции для операции с маршрутом:'
    raise InstanceNotExistError unless station = Station.all[gets.chomp]
    puts 'Введите название маршрута:'
    raise InstanceNotExistError unless route = Route.all[gets.chomp]
    if route.stations.include? station
      puts route.delete(station) ? "#{station.title} удалена из маршрута" : "#{station.title} является терминальной станцией маршрута,удаление невозможно"
    else
      puts route.insert(station) ? "#{station.title} добавлена в маршрут" : 'Что-то пошло не так.Убедитесь в корректности ввода'
    end
  end

  def route_set!
    puts 'Введите номер поезда:'
    raise InstanceNotExistError unless train = Train.trains[gets.chomp.to_s]
    puts 'Введите название маршрута:'
    raise InstanceNotExistError unless route = Route.all[gets.chomp]
    puts "Поезду #{train.number} присвоен маршрут: #{train.route!(route)}"
  end

  def carriage_ops!
    puts 'Введите номер поезда'
    raise InstanceNotExistError unless train = Train.trains[gets.chomp.to_s]
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
      else 
        raise InstanceTypeError
      end
    when '2'
      puts train.detach ? 'Вагон отцеплен' : 'Операция не выполнена.Проверьте корректность ввода'
    else
        raise InstanceTypeError
    end
  end

  def train_move!
    puts 'Введите номер поезда'
    raise InstanceNotExistError unless train = Train.trains[gets.chomp.to_s]
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
    else
      raise InstanceTypeError 
    end
  end

  def station_trains
    puts 'Введите название станции:'
    raise InstanceNotExistError unless station = Station.all[gets.chomp] 
    puts station.trains 
  end

  def station_list
    puts Station.all.keys.tap{|output| puts 'Станций не найдено' if output == []}
  end
end
